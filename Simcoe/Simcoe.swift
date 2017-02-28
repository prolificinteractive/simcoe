//
//  Simcoe.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation

private let sessionToken = String(arc4random_uniform(999999))

/// The root analytics engine.
public final class Simcoe {

    /// The Simcoe session.
    static var session: String {
        return sessionToken
    }

    /// The default analytics logging engine.
    public static let engine = Simcoe(tracker: Tracker())

    /// The analytics data tracker.
    public let tracker: Tracker

    /// Simcoe providers.
    public var providers = [AnalyticsTracking]() {
        didSet {
            for provider in providers {
                provider.start()
            }
        }
    }

    /// Initializes a new instance using the specified tracker.
    ///
    /// - Parameter tracker: The tracker to use.
    init(tracker: Tracker) {
        self.tracker = tracker
    }

    /// Retrieves the provider based on its kind from the current list of providers.
    ///
    /// - Parameter _: The kind of provider to retrieve.
    /// - Returns: The provider if it is exists; otherwise nil.
    public static func provider<T: AnalyticsTracking>(ofKind _: T) -> T? {
        return engine.providers.filter({ provider in return provider is T }).first as? T
    }

    /// Begins running using the input providers.
    ///
    /// - Parameter providers: The providers to use for analytics tracking.
    public static func run(with providers: [AnalyticsTracking] = [AnalyticsTracking]()) {
        var analyticsProviders = providers
        if analyticsProviders.isEmpty {
            analyticsProviders.append(EmptyProvider())
        }

        engine.providers = analyticsProviders
    }

    /// Force uploads all pending events.
    public static func flush() {
        engine.providers.forEach {
            $0.flush()
        }
    }

    /// Writes the event.
    ///
    /// - Parameters:
    ///   - providers: The list of providers.
    ///   - description: The event description.
    ///   - action: The action description.
    public func write<T>(toProviders providers: [T], description: String, action: (T) -> TrackingResult) {
        let writeEvents = providers.map { provider -> WriteEvent in
            let result = action(provider)
            return WriteEvent(provider: provider as! AnalyticsTracking, trackingResult: result)
        }

        let event = Event(writeEvents: writeEvents, description: description)
        tracker.track(event: event)
    }

    fileprivate func findProviders<T>(_ providers: [AnalyticsTracking]) -> [T] {
        return providers
            .map { provider in return provider as? T }
            .flatMap { $0}
    }

    // MARK: - CartLogging

    /// Logs the addition of a product to the cart.
    ///
    /// - Parameters:
    ///   - product: The SimcoeProductConvertible instance.
    ///   - eventProperties: The event properties.
    public static func logAddToCart<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) {
        engine.logAddToCart(product, eventProperties: eventProperties)
    }

    /// Logs the addition of a product to the cart.
    ///
    /// - Parameters:
    ///   - product: The SimcoeProductConvertible instance.
    ///   - eventProperties: The event properties.
    func logAddToCart<T: SimcoeProductConvertible>(_ product: T,
                      eventProperties: Properties?, providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [CartLogging] = findProviders(providers)
        let simcoeProduct = product.toSimcoeProduct()
        let propertiesString = eventProperties != nil ? "=> \(eventProperties!.description)" : ""
        let productPrice = String(format: "%.2f", Double(simcoeProduct.price ?? 0.0))

        let addToCartDescription
            = "\(simcoeProduct.quantity) x \(simcoeProduct.productName)(\(simcoeProduct.productId)) at \(productPrice) Added to cart \(propertiesString)"

        write(toProviders: providers,
              description: addToCartDescription) { addToCartLogger in
                return addToCartLogger.logAddToCart(product, eventProperties: eventProperties)
        }
    }

    /// Logs the removal of a product from the cart.
    ///
    /// - Parameters:
    ///   - product: The SimcoeProductConvertible instance.
    ///   - eventProperties: The event properties.
    public static func logRemoveFromCart<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) {
        engine.logRemoveFromCart(product, eventProperties: eventProperties)
    }

    /// Logs the removal of a product from the cart.
    ///
    /// - Parameters:
    ///   - product: The SimcoeProductConvertible instance.
    ///   - eventProperties: The event properties.
    func logRemoveFromCart<T: SimcoeProductConvertible>(_ product: T,
                           eventProperties: Properties?, providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [CartLogging] = findProviders(providers)
        let simcoeProduct = product.toSimcoeProduct()
        let propertiesString = eventProperties != nil ? "=> \(eventProperties!.description)" : ""
        let productPrice = String(format: "%.2f", Double(simcoeProduct.price ?? 0.0))

        let removeFromCartDescription
            = "\(simcoeProduct.quantity) x \(simcoeProduct.productName)(\(simcoeProduct.productId)) at \(productPrice) Removed from cart \(propertiesString)"

        write(toProviders: providers,
              description: removeFromCartDescription) { removeFromCartLogger in
                return removeFromCartLogger.logRemoveFromCart(product, eventProperties: eventProperties)
        }
    }

    // MARK: - CheckoutTracking

    /// Tracks a checkout event.
    ///
    /// - Parameters:
    ///   - products: The products.
    ///   - eventProperties: The event properties.
    public static func trackCheckoutEvent<T: SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?) {
        engine.trackCheckoutEvent(products, eventProperties: eventProperties)
    }

    /// Tracks a checkout event.
    ///
    /// - Parameters:
    ///   - products: The products.
    ///   - eventProperties: The event properties.
    func trackCheckoutEvent<T: SimcoeProductConvertible>(_ products: [T],
                            eventProperties: Properties?, providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [CheckoutTracking] = findProviders(providers)
        let propertiesString = eventProperties != nil ? "=> \(eventProperties!.description)" : ""

        let productsList = products.map { $0.toSimcoeProduct().productName }.joined(separator: ", ")

        let checkoutEventDescription
            = "Checkout: \(productsList). \(propertiesString)"

        write(toProviders: providers,
              description: checkoutEventDescription) { checkoutTracker in
                return checkoutTracker.trackCheckoutEvent(products, eventProperties: eventProperties)
        }
    }

    // MARK: - ErrorLogging

    /// Logs the error with optional additional properties.
    ///
    /// - Parameters:
    ///   - error: The error to log.
    ///   - properties: The optional additional properties.
    public static func log(error: String, withAdditionalProperties properties: Properties? = nil) {
        engine.log(error: error, withAdditionalProperties: properties)
    }

    /// Logs the error with optional additional properties.
    ///
    /// - Parameters:
    ///   - error: The error to log.
    ///   - properties: The optional additional properties.
    func log(error: String, withAdditionalProperties properties: Properties? = nil,
             providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [ErrorLogging] = findProviders(providers)

        let propertiesString = properties != nil ? "=> \(properties!.description)" : ""
        write(toProviders: providers, description: "Error: \(error) \(propertiesString)") { errorLogger in
            return errorLogger.log(error: error, withAdditionalProperties: properties)
        }
    }

    // MARK: - EventTracking

    /// Tracks an analytics action or event.
    ///
    /// - Parameters:
    ///   - event: The event that occurred.
    ///   - properties: The optional additional properties.
    public static func track(event: String, withAdditionalProperties properties: Properties? = nil) {
        engine.track(event: event, withAdditionalProperties: properties)
    }

    /// Tracks the event.
    ///
    /// - Parameters:
    ///   - event: The event to track.
    ///   - properties: The optional additional properties.
    func track(event: String, withAdditionalProperties properties: Properties? = nil,
               providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [EventTracking] = findProviders(providers)

        let propertiesString = properties != nil ? "=> \(properties!.description)" : ""
        write(toProviders: providers, description: "Event: \(event) \(propertiesString)") { eventTracker in
            return eventTracker.track(event: event, withAdditionalProperties: properties)
        }
    }

    // MARK: - LifetimeValueTracking

    /// Tracks the lifetime value.
    ///
    /// - Parameters:
    ///   - key: The lifetime value's identifier.
    ///   - value: The lifetime value.
    public static func trackLifetimeValue(_ key: String, value: Any, withAdditionalProperties properties: Properties?) {
        engine.trackLifetimeValue(key, value: value, withAdditionalProperties: properties)
    }

    /// Tracks the lifetime value.
    ///
    /// - Parameters:
    ///   - key: The lifetime value's identifier.
    ///   - value: The lifetime value.
    func trackLifetimeValue(_ key: String, value: Any, withAdditionalProperties properties: Properties?) {
        let providers: [LifetimeValueTracking] = findProviders()

        write(toProviders: providers, description: "Tracking lifetime value with key: \(key) value: \(value)") { lifetimeValueTracker in
            return lifetimeValueTracker.trackLifetimeValue(key, value: value, withAdditionalProperties: properties)
        }
    }

    /// Track the lifetime values.
    ///
    /// - Parameter attributes: The lifetime attribute values.
    public static func trackLifetimeValues(_ attributes: Properties, withAdditionalProperties properties: Properties?) {
        engine.trackLifetimeValues(attributes, withAdditionalProperties: properties)
    }

    /// Track the lifetime values.
    ///
    /// - Parameter attributes: The lifetime attribute values.
    func trackLifetimeValues(_ attributes: Properties, withAdditionalProperties properties: Properties?) {
        let providers: [LifetimeValueTracking] = findProviders()

        attributes.forEach { (key, value) in
            write(toProviders: providers, description: "Tracking lifetime value with key: \(key) value: \(value)") { lifetimeValueTracker in
                return lifetimeValueTracker.trackLifetimeValue(key, value: value, withAdditionalProperties: properties)
            }
        }
    }

    // MARK: - LocationTracking

    /// Tracks location.
    ///
    /// - Parameters:
    ///   - location: The location to track.
    ///   - properties: The optional additional properties.
    public static func track(location: CLLocation, withAdditionalProperties properties: Properties?) {
        engine.track(location: location, withAdditionalProperties: properties)
    }

    /// Tracks location.
    ///
    /// - Parameters:
    ///   - location: The location to track.
    ///   - properties: The optional additional properties.
    func track(location: CLLocation, withAdditionalProperties properties: Properties?,
               providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [LocationTracking] = findProviders(providers)

        write(toProviders: providers, description: "User's Location") { locationTracker in
            return locationTracker.track(location: location, withAdditionalProperties: properties)
        }
    }

    // MARK: - PageViewTracking

    /// Tracks the page view.
    ///
    /// - Parameters:
    ///   - pageView: The page view to track.
    ///   - properties: The optional additional properties.
    public static func track(pageView: String, withAdditionalProperties properties: Properties? = nil) {
        engine.track(pageView: pageView, withAdditionalProperties: properties)
    }

    /// Tracks the page view.
    ///
    /// - Parameters:
    ///   - pageView: The page view to track.
    ///   - properties: The optional additional properties.
    func track(pageView: String, withAdditionalProperties properties: Properties? = nil,
               providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [PageViewTracking] = findProviders(providers)

        write(toProviders: providers, description: "Page View: \(pageView)") { (provider: PageViewTracking) in
            return provider.track(pageView: pageView, withAdditionalProperties: properties)
        }
    }

    // MARK: - PurchaseTracking

    /// Tracks a purchase event.
    ///
    /// - Parameters:
    ///   - products: The products.
    ///   - eventProperties: The event properties
    public static func trackPurchaseEvent<T: SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?) {
        engine.trackPurchaseEvent(products, eventProperties: eventProperties)
    }

    /// Tracks a purchase event.
    ///
    /// - Parameters:
    ///   - products: The products.
    ///   - eventProperties: The event properties
    func trackPurchaseEvent<T: SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?,
                            providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [PurchaseTracking] = findProviders(providers)
        let propertiesString = eventProperties != nil ? "=> \(eventProperties!.description)" : ""

        let productsList = products.map { $0.toSimcoeProduct().productName }.joined(separator: ", ")

        let purchaseEventDescription
            = "Purchase: \(productsList). \(propertiesString)"

        write(toProviders: providers,
              description: purchaseEventDescription) { purchaseTracker in
                return purchaseTracker.trackPurchaseEvent(products, eventProperties: eventProperties)
        }
    }

    // MARK: - SuperPropertyTracking

    /// Sets the super properties.
    ///
    /// - Parameter superProperties: The super properties.
    public static func set(superProperties: Properties) {
        engine.set(superProperties: superProperties)
    }

    /// Sets the super properties.
    ///
    /// - Parameters:
    ///   - superProperties: The super properties.
    ///   - providers: The providers.
    func set(superProperties: Properties, providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [SuperPropertyTracking] = findProviders(providers)

        write(toProviders: providers, description: "Setting super properties: \(superProperties)") { superPropertyTracker in
            return superPropertyTracker.set(superProperties: superProperties)
        }
    }

    /// Unsets the super property.
    ///
    /// - Parameter superProperty: The super property.
    public static func unset(superProperty: String) {
        engine.unset(superProperty: superProperty)
    }

    /// Unsets the super property.
    ///
    /// - Parameters:
    ///   - superProperty: The super property.
    ///   - providers: The providers.
    func unset(superProperty: String, providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [SuperPropertyTracking] = findProviders(providers)

        write(toProviders: providers, description: "Unsetting super property: \(superProperty)") { superPropertyTracker in
            return superPropertyTracker.unset(superProperty: superProperty)
        }
    }

    /// Clears all currently set super properties.
    ///
    public static func clearSuperProperties() {
        engine.clearSuperProperties()
    }

    /// Clears all currently set super properties.
    ///
    /// - Parameter providers: The providers.
    func clearSuperProperties(providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [SuperPropertyTracking] = findProviders(providers)

        write(toProviders: providers, description: "Clearing all super properties.") { superPropertyTracker in
            return superPropertyTracker.clearSuperProperties()
        }
    }

    // MARK: - TimedEventTracking

    /// Starts the timed event.
    ///
    /// - Parameters:
    ///   - event: The event name.
    ///   - eventProperties: The event properties.
    public static func start(timedEvent event: String, withAddtionalProperties properties: Properties?) {
        engine.start(timedEvent: event, withAdditionalProperties: properties)
    }

    /// Starts the timed event.
    ///
    /// - Parameters:
    ///   - event: The event name.
    ///   - eventProperties: The event properties.
    ///   - providers: The providers.
    func start(timedEvent event: String, withAdditionalProperties properties: Properties?, providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [TimedEventTracking] = findProviders(providers)

        let propertiesString = properties != nil ? "=> \(properties!.description)" : ""
        write(toProviders: providers, description: "Starting Timed Event: \(event) \(propertiesString)") { timedEventTracker in
            return timedEventTracker.start(timedEvent: event, withAdditionalProperties: properties)
        }
    }

    /// Stops the timed event.
    ///
    /// - Parameters:
    ///   - event: The event name.
    ///   - eventProperties: The event properties.
    public static func end(timedEvent event: String, withAdditionalProperties properties: Properties?) {
        engine.end(timedEvent: event, withAdditionalProperties: properties)
    }

    /// Stops the timed event.
    ///
    /// - Parameters:
    ///   - event: The event name.
    ///   - eventProperties: The event properties.
    ///   - providers: The providers.
    func end(timedEvent event: String, withAdditionalProperties properties: Properties?, providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [TimedEventTracking] = findProviders(providers)

        let propertiesString = properties != nil ? "=> \(properties!.description)" : ""
        write(toProviders: providers, description: "Ending Timed Event: \(event) \(propertiesString)") { timedEventTracker in
            return timedEventTracker.start(timedEvent: event, withAdditionalProperties: properties)
        }
    }

    // MARK: - UserAttributeTracking

    /// Sets the User Attribute.
    ///
    /// - Parameters:
    ///   - key: The attribute key to log.
    ///   - value: The attribute value to log.
    public static func setUserAttribute(_ key: String, value: Any) {
        engine.setUserAttribute(key, value: value)
    }

    /// Sets the User Attribute.
    ///
    /// - Parameters:
    ///   - key: The attribute key to log.
    ///   - value: The attribute value to log.
    ///   - providers: The providers.
    func setUserAttribute(_ key: String, value: Any, providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [UserAttributeTracking] = findProviders(providers)
        
        write(toProviders: providers, description: "Setting user attribute with key: \(key) value: \(value)") { attributeSetter in
            return attributeSetter.setUserAttribute(key, value: value)
        }
    }

    /// Sets the User Attributes.
    ///
    /// - Parameter attributes: The attribute values to log.
    public static func setUserAttributes(_ attributes: Properties) {
        engine.setUserAttributes(attributes)
    }

    /// Sets the User Attributes.
    ///
    /// - Parameters:
    ///   - attributes: The attribute values to log.
    ///   - providers: The providers.
    func setUserAttributes(_ attributes: Properties, providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [UserAttributeTracking] = findProviders(providers)

        var description = ""
        attributes.forEach {
            description += "Setting user attribute with key: \($0) value: \($1)\n"
        }

        write(toProviders: providers, description: description) { attributeSetter in
            return attributeSetter.setUserAttributes(attributes)
        }
    }

    // MARK: - ViewDetailLogging

    /// Logs the action of viewing a product's details.
    ///
    /// - Parameters:
    ///   - product: The SimcoeProductConvertible instance.
    ///   - eventProperties: The event properties.
    public static func logViewDetail<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) {
        engine.logViewDetail(product, eventProperties: eventProperties)
    }

    /// Logs the action of viewing a product's details.
    ///
    /// - Parameters:
    ///   - product: The SimcoeProductConvertible instance.
    ///   - eventProperties: The event properties.
    func logViewDetail<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?,
                       providers: [AnalyticsTracking] = Simcoe.engine.providers) {
        let providers: [ViewDetailLogging] = findProviders(providers)
        let simcoeProduct = product.toSimcoeProduct()
        let propertiesString = eventProperties != nil ? "=> \(eventProperties!.description)" : ""

        let viewDetailDescription
            = "Viewed details of: \(simcoeProduct.productName)(\(simcoeProduct.productId)). \(propertiesString)"

        write(toProviders: providers,
              description: viewDetailDescription) { viewDetailLogger in
                return viewDetailLogger.logViewDetail(product, eventProperties: eventProperties)
        }
    }

}
