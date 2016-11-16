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

    /**
     Initializes a new instance using the specified tracker.

     - parameter tracker: The tracker to use.

     - returns: An instance of Simcoe.
     */
    init(tracker: Tracker) {
        self.tracker = tracker
    }

    /**
     Retrieves the provider based on its kind from the current list of providers.

     - parameter _: The kind of provider to retrieve.

     - returns: The provider if it is exists; otherwise nil.
     */
    public static func provider<T: AnalyticsTracking>(ofKind _: T) -> T? {
        return engine.providers.filter({ provider in return provider is T }).first as? T
    }

    /**
     Begins running using the input providers.

     - parameter providers: The providers to use for analytics tracking.
     */
    public static func run(with providers: [AnalyticsTracking] = [AnalyticsTracking]()) {
        var analyticsProviders = providers
        if analyticsProviders.isEmpty {
            analyticsProviders.append(EmptyProvider())
        }

        engine.providers = analyticsProviders
    }

    /**
     Writes the event.

     - parameter providers:   The list of provides.
     - parameter description: The event description.
     - parameter action:      The action description.
     */
    public func write<T>(toProviders providers: [T], description: String, action: T -> TrackingResult) {
        let writeEvents = providers.map { provider -> WriteEvent in
            let result = action(provider)
            return WriteEvent(provider: provider as! AnalyticsTracking, trackingResult: result)
        }

        let event = Event(writeEvents: writeEvents, description: description)
        tracker.track(event: event)
    }

    private func findProviders<T>() -> [T] {
        return providers
            .map { provider in return provider as? T }
            .flatMap { $0 }
    }

    // MARK: - CartLogging

    /// Logs the addition of a product to the cart.
    ///
    /// - parameter product:         The SimcoeProductConvertible instance.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    public static func logAddToCart<T: SimcoeProductConvertible>(product: T, eventProperties: Properties?) {
        engine.logAddToCart(product, eventProperties: eventProperties)
    }

    /// Logs the addition of a product to the cart.
    ///
    /// - parameter product:         The SimcoeProductConvertible instance.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    func logAddToCart<T: SimcoeProductConvertible>(product: T, eventProperties: Properties?) {
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
    /// - parameter product:         The SimcoeProductConvertible instance.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    public static func logRemoveFromCart<T: SimcoeProductConvertible>(product: T, eventProperties: Properties?) {
        engine.logRemoveFromCart(product, eventProperties: eventProperties)
    }

    /// Logs the removal of a product from the cart.
    ///
    /// - parameter product:         The SimcoeProductConvertible instance.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    func logRemoveFromCart<T: SimcoeProductConvertible>(product: T, eventProperties: Properties?) {
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
    /// - parameter products:        The products.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    public static func trackCheckoutEvent<T: SimcoeProductConvertible>(products: [T], eventProperties: Properties?) {
        engine.trackCheckoutEvent(products, eventProperties: eventProperties)
    }

    /// Tracks a checkout event.
    ///
    /// - parameter products:        The products.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    func trackCheckoutEvent<T: SimcoeProductConvertible>(products: [T], eventProperties: Properties?) {
        let providers: [CheckoutTracking] = findProviders()
        let propertiesString = eventProperties != nil ? "=> \(eventProperties!.description)" : ""

        let productsList = products.map { $0.toSimcoeProduct().productName }.joinWithSeparator(", ")

        let checkoutEventDescription
            = "Checkout: \(productsList). \(propertiesString)"

        write(toProviders: providers,
              description: checkoutEventDescription) { checkoutTracker in
                return checkoutTracker.trackCheckoutEvent(products, eventProperties: eventProperties)
        }
    }

    // MARK: - ErrorLogging

    /**
     Logs the error with optional additional properties.

     - parameter error:      The error to log.
     - parameter properties: The optional additional properties.
     */
    public static func logError(error: String, withAdditionalProperties properties: Properties? = nil) {
        engine.logError(error, withAdditionalProperties: properties)
    }

    /**
     Logs the error with optional additional properties.

     - parameter error:      The error to log.
     - parameter properties: The optional additional properties.
     */
    func logError(error: String, withAdditionalProperties properties: Properties? = nil) {
        let providers: [ErrorLogging] = findProviders()

        let propertiesString = properties != nil ? "=> \(properties!.description)" : ""
        write(toProviders: providers, description: "Error: \(error) \(propertiesString)") { errorLogger in
            return errorLogger.logError(error, withAdditionalProperties: properties)
        }
    }

    // MARK: - EventTracking

    /**
     Tracks an analytics action or event.

     - parameter event:      The event that occurred.
     - parameter properties: The optional additional properties.
     */
    public static func trackEvent(event: String, withAdditionalProperties properties: Properties? = nil) {
        engine.trackEvent(event, withAdditionalProperties: properties)
    }

    /**
     Tracks the event.

     - parameter event:      The event to track.
     - parameter properties: The optional additional properties.
     */
    func trackEvent(event: String, withAdditionalProperties properties: Properties? = nil) {
        let providers: [EventTracking] = findProviders()

        let propertiesString = properties != nil ? "=> \(properties!.description)" : ""
        write(toProviders: providers, description: "Event: \(event) \(propertiesString)") { eventTracker in
            return eventTracker.trackEvent(event, withAdditionalProperties: properties)
        }
    }

    // MARK: - LifetimeValueIncreasing

    /**
     Tracks the lifetime value increase.

     - parameter amount:     The amount to increase that lifetime value for.
     - parameter item:       The optional item to extend.
     - parameter properties: The optional additional properties.
     */
    public static func trackLifetimeIncrease(byAmount amount: Double = 1, forItem item: String? = nil,
                                                      withAdditionalProperties properties: Properties? = nil) {
        engine.trackLifetimeIncrease(byAmount: amount, forItem: item, withAdditionalProperties: properties)
    }

    /**
     Tracks the lifetime value increase.

     - parameter amount:     The amount to increase that lifetime value for.
     - parameter item:       The optional item to extend.
     - parameter properties: The optional additional properties.
     */
    func trackLifetimeIncrease(byAmount amount: Double = 1, forItem item: String? = nil,
                                        withAdditionalProperties properties: Properties? = nil) {
        let providers: [LifetimeValueIncreasing] = findProviders()

        write(toProviders: providers, description: "Lifetime Value increased by \(amount) for \(item ?? "")") { lifeTimeValueIncreaser in
            return lifeTimeValueIncreaser
                .increaseLifetimeValue(byAmount: amount, forItem: item, withAdditionalProperties: properties)
        }
    }

    // MARK: - LocationTracking

    /**
     Tracks a user's location.

     - parameter location:   The user's location.
     - parameter properties: The optional additional properties.
     */
    public static func trackLocation(location: CLLocation, withAdditionalProperties properties: Properties?) {
        engine.trackLocation(location, withAdditionalProperties: properties)
    }

    /**
     Tracks a user's location.

     - parameter location:   The user's location.
     - parameter properties: The optional additional properties.
     */
    func trackLocation(location: CLLocation, withAdditionalProperties properties: Properties?) {
        let providers: [LocationTracking] = findProviders()

        write(toProviders: providers, description: "User's Location") { locationTracker in
            return locationTracker.trackLocation(location, withAdditionalProperties: properties)
        }
    }

    // MARK: - PageViewTracking

    /**
     Tracks a page view.

     - parameter pageView:   The page view event.
     - parameter properties: The optional additional properties.
     */
    public static func trackPageView(pageView: String, withAdditionalProperties properties: Properties? = nil) {
        engine.trackPageView(pageView, withAdditionalProperties: properties)
    }

    /**
     Tracks the page view.

     - parameter pageView:   The page view to track.
     - parameter properties: The optional additional properties.
     */
    func trackPageView(pageView: String, withAdditionalProperties properties: Properties? = nil) {
        let providers: [PageViewTracking] = findProviders()

        write(toProviders: providers, description: "Page View: \(pageView)") { (provider: PageViewTracking) in
            return provider.trackPageView(pageView, withAdditionalProperties: properties)
        }
    }

    // MARK: - PurchaseTracking

    /// Tracks a purchase event.
    ///
    /// - parameter products:        The products.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    public static func trackPurchaseEvent<T: SimcoeProductConvertible>(products: [T], eventProperties: Properties?) {
        engine.trackPurchaseEvent(products, eventProperties: eventProperties)
    }

    /// Tracks a purchase event.
    ///
    /// - parameter products: The products.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    func trackPurchaseEvent<T: SimcoeProductConvertible>(products: [T], eventProperties: Properties?) {
        let providers: [PurchaseTracking] = findProviders()
        let propertiesString = eventProperties != nil ? "=> \(eventProperties!.description)" : ""

        let productsList = products.map { $0.toSimcoeProduct().productName }.joinWithSeparator(", ")

        let purchaseEventDescription
            = "Purchase: \(productsList). \(propertiesString)"

        write(toProviders: providers,
              description: purchaseEventDescription) { purchaseTracker in
                return purchaseTracker.trackPurchaseEvent(products, eventProperties: eventProperties)
        }
    }

    // MARK: - UserAttributeTracking

    /**
     Sets the User Attribute.

     - parameter key:   The key of the user attribute
     - parameter value: the value of the user attribute
     */
    public static func setUserAttribute(key: String, value: AnyObject) {
        engine.setUserAttribute(key, value: value)
    }

    /**
     Sets the User Attribute.

     - parameter key:   The key of the user attribute
     - parameter value: the value of the user attribute
     */
    func setUserAttribute(key: String, value: AnyObject) {
        let providers: [UserAttributeTracking] = findProviders()
        
        write(toProviders: providers, description: "Setting user attribute with key: \(key) value:\(value)") { attributeSetter in
            return attributeSetter.setUserAttribute(key, value: value)
        }
    }

    // MARK: - ViewDetailLogging

    /// Logs the action of viewing a product's details.
    ///
    /// - parameter product: The SimcoeProductConvertible instance.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    public static func logViewDetail<T: SimcoeProductConvertible>(product: T, eventProperties: Properties?) {
        engine.logViewDetail(product, eventProperties: eventProperties)
    }

    /// Logs the action of viewing a product's details.
    ///
    /// - parameter product: The SimcoeProductConvertible instance.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    func logViewDetail<T: SimcoeProductConvertible>(product: T, eventProperties: Properties?) {
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
