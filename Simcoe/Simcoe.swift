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

    /// Stops analytics tracking on all providers.
    public static func stop() {
        engine.providers.forEach {
            $0.stop()
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

    fileprivate func findProviders<T>() -> [T] {
        return providers
            .map { provider in return provider as? T }
            .flatMap { $0 }
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
    func logAddToCart<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) {
        let providers: [CartLogging] = findProviders()
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
    func logRemoveFromCart<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) {
        let providers: [CartLogging] = findProviders()
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
    func trackCheckoutEvent<T: SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?) {
        let providers: [CheckoutTracking] = findProviders()
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
    func log(error: String, withAdditionalProperties properties: Properties? = nil) {
        let providers: [ErrorLogging] = findProviders()

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
    func track(event: String, withAdditionalProperties properties: Properties? = nil) {
        let providers: [EventTracking] = findProviders()

        let propertiesString = properties != nil ? "=> \(properties!.description)" : ""
        write(toProviders: providers, description: "Event: \(event) \(propertiesString)") { eventTracker in
            return eventTracker.track(event: event, withAdditionalProperties: properties)
        }
    }

    // MARK: - LifetimeValueIncreasing

    /// Tracks the lifetime value increase.
    ///
    /// - Parameters:
    ///   - amount: The amount to increase that lifetime value for.
    ///   - item: The optional item to extend.
    ///   - properties: The optional additional properties.
    public static func trackLifetimeIncrease(byAmount amount: Double = 1, forItem item: String? = nil,
                                                      withAdditionalProperties properties: Properties? = nil) {
        engine.trackLifetimeIncrease(byAmount: amount, forItem: item, withAdditionalProperties: properties)
    }

    /// Tracks the lifetime value increase.
    ///
    /// - Parameters:
    ///   - amount: The amount to increase that lifetime value for.
    ///   - item: The optional item to extend.
    ///   - properties: The optional additional properties.
    func trackLifetimeIncrease(byAmount amount: Double = 1, forItem item: String? = nil,
                                        withAdditionalProperties properties: Properties? = nil) {
        let providers: [LifetimeValueIncreasing] = findProviders()

        write(toProviders: providers, description: "Lifetime Value increased by \(amount) for \(item ?? "")") { lifeTimeValueIncreaser in
            return lifeTimeValueIncreaser
                .increaseLifetimeValue(byAmount: amount, forItem: item, withAdditionalProperties: properties)
        }
    }

    // MARK: - LifetimeValueTracking

    /// Tracks the lifetime value.
    ///
    /// - Parameters:
    ///   - key: The lifetime value's identifier.
    ///   - value: The lifetime value.
    public static func trackLifetimeValue(_ key: String, value: Any) {
        engine.trackLifetimeValue(key, value: value)
    }

    /// Tracks the lifetime value.
    ///
    /// - Parameters:
    ///   - key: The lifetime value's identifier.
    ///   - value: The lifetime value.
    func trackLifetimeValue(_ key: String, value: Any) {
        let providers: [LifetimeValueTracking] = findProviders()

        write(toProviders: providers, description: "Tracking lifetime value with key: \(key) value: \(value)") { lifetimeValueTracker in
            return lifetimeValueTracker.trackLifetimeValue(key, value: value)
        }
    }

    /// Track the lifetime values.
    ///
    /// - Parameter attributes: The lifetime attribute values.
    public static func trackLifetimeValues(_ attributes: Properties) {
        engine.trackLifetimeValues(attributes)
    }

    /// Track the lifetime values.
    ///
    /// - Parameter attributes: The lifetime attribute values.
    func trackLifetimeValues(_ attributes: Properties) {
        let providers: [LifetimeValueTracking] = findProviders()

        attributes.forEach { (key, value) in
            write(toProviders: providers, description: "Tracking lifetime value with key: \(key) value: \(value)") { lifetimeValueTracker in
                return lifetimeValueTracker.trackLifetimeValue(key, value: value)
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
    func track(location: CLLocation, withAdditionalProperties properties: Properties?) {
        let providers: [LocationTracking] = findProviders()

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
    func track(pageView: String, withAdditionalProperties properties: Properties? = nil) {
        let providers: [PageViewTracking] = findProviders()

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
    func trackPurchaseEvent<T: SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?) {
        let providers: [PurchaseTracking] = findProviders()
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
    /// - Parameter properties: The super properties.
    public static func set(superProperties properties: Properties) {
        engine.set(superProperties: properties)
    }

    /// Sets the super properties.
    ///
    /// - Parameter properties: The super properties.
    func set(superProperties properties: Properties) {
        let providers: [SuperPropertyTracking] = findProviders()

        write(toProviders: providers, description: "Setting super properties: \(properties)") { superPropertyTracker in
            return superPropertyTracker.set(superProperties: properties)
        }
    }

    /// Increments the super property.
    ///
    /// - Parameters:
    ///   - property: The super property.
    ///   - value: The amount to increment the super property by.
    public static func increment(superProperty property: String, value: Double) {
        engine.increment(superProperty: property, value: value)
    }

    /// Increments the super property.
    ///
    /// - Parameters:
    ///   - property: The super property.
    ///   - value: The amount to increment the super property by.
    func increment(superProperty property: String, value: Double) {
        let providers: [SuperPropertyTracking] = findProviders()

        write(toProviders: providers, description: "Incremented super property: \(property) by \(value)") { superPropertyTracker in
            return superPropertyTracker.increment(superProperty: property, value: value)
        }
    }

    // MARK: - TimedEventTracking

    /// Starts the timed event.
    ///
    /// - Parameters:
    ///   - event: The event name.
    ///   - eventProperties: The event properties.
    public static func start(timedEvent event: String, eventProperties: Properties?) {
        engine.start(timedEvent: event, eventProperties: eventProperties)
    }

    /// Starts the timed event.
    ///
    /// - Parameters:
    ///   - event: The event name.
    ///   - eventProperties: The event properties.
    func start(timedEvent event: String, eventProperties: Properties?) {
        let providers: [TimedEventTracking] = findProviders()

        let propertiesString = eventProperties != nil ? "=> \(eventProperties!.description)" : ""
        write(toProviders: providers, description: "Starting Timed Event: \(event) \(propertiesString)") { timedEventTracker in
            return timedEventTracker.start(timedEvent: event, eventProperties: eventProperties)
        }
    }

    /// Stops the timed event.
    ///
    /// - Parameters:
    ///   - event: The event name.
    ///   - eventProperties: The event properties.
    public static func end(timedEvent event: String, eventProperties: Properties?) {
        engine.end(timedEvent: event, eventProperties: eventProperties)
    }

    /// Stops the timed event.
    ///
    /// - Parameters:
    ///   - event: The event name.
    ///   - eventProperties: The event properties.
    func end(timedEvent event: String, eventProperties: Properties?) {
        let providers: [TimedEventTracking] = findProviders()

        let propertiesString = eventProperties != nil ? "=> \(eventProperties!.description)" : ""
        write(toProviders: providers, description: "Ending Timed Event: \(event) \(propertiesString)") { timedEventTracker in
            return timedEventTracker.start(timedEvent: event, eventProperties: eventProperties)
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
    func setUserAttribute(_ key: String, value: Any) {
        let providers: [UserAttributeTracking] = findProviders()
        
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
    /// - Parameter attributes: The attribute values to log.
    func setUserAttributes(_ attributes: Properties) {
        let providers: [UserAttributeTracking] = findProviders()

        attributes.forEach { (key, value) in
            write(toProviders: providers, description: "Setting user attribute with key: \(key) value: \(value)") { attributeSetter in
                return attributeSetter.setUserAttribute(key, value: value)
            }
        }
    }

    // MARK: - UserPropertyTracking

    /// Sets the user properties.
    ///
    /// - Parameter properties: The user properties.
    public static func set(userProperties properties: Properties) {
        engine.set(userProperties: properties)
    }

    /// Sets the user properties.
    ///
    /// - Parameter properties: The user properties.
    func set(userProperties properties: Properties) {
        let providers: [UserPropertyTracking] = findProviders()

        write(toProviders: providers, description: "Setting user properties: \(properties)") { userPropertyTracker in
            return userPropertyTracker.set(userProperties: properties)
        }
    }

    /// Sets the user alias.
    ///
    /// - Parameter userId: The user alias.
    public static func set(userAlias userId: String) {
        engine.set(userAlias: userId)
    }

    /// Sets the user alias.
    ///
    /// - Parameter userId: The user alias.
    func set(userAlias userId: String) {
        let providers: [UserPropertyTracking] = findProviders()

        write(toProviders: providers, description: "Setting user alias: \(userId)") { userPropertyTracker in
            return userPropertyTracker.set(userAlias: userId)
        }
    }

    /// Increments the user property.
    ///
    /// - Parameters:
    ///   - property: The user property.
    ///   - value: The amonut to increment the user property by.
    public static func increment(userProperty property: String, value: Double) {
        engine.increment(userProperty: property, value: value)
    }

    /// Increments the user property.
    ///
    /// - Parameters:
    ///   - property: The user property.
    ///   - value: The amonut to increment the user property by.
    func increment(userProperty property: String, value: Double) {
        let providers: [UserPropertyTracking] = findProviders()

        write(toProviders: providers, description: "Incremented user property: \(property) by \(value)") { userPropertyTracker in
            return userPropertyTracker.increment(userProperty: property, value: value)
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
    func logViewDetail<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) {
        let providers: [ViewDetailLogging] = findProviders()
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
