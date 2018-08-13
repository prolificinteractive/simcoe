//
//  mParticleAnalyticsHandler.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import mParticle_Apple_SDK

/// Simcoe Analytics handler for the MParticle iOS SDK.
public class mParticle {

    fileprivate static let unknownErrorMessage = "An unknown error occurred."

    fileprivate var currentUser: MParticleUser? {
        return MParticle.sharedInstance().identity.currentUser
    }

    /// The name of the tracker.
    public let name = "mParticle"

    /// Initializes and starts the SDK with the input options.
    ///
    /// - Parameter options: The mParticle SDK options.
    public init(options: MParticleOptions) {
        MParticle.sharedInstance().start(with: options)
    }

    /// Starts the mParticle SDK with the api_key and api_secret saved in MParticleConfig.plist.
    /// - warning: This may throw an error if the MPartcileConfig.plist file is not found in the main bundle.
    public init() {
        MParticle.sharedInstance().start()
    }

}

// MARK: - CartLogging

extension mParticle: CartLogging {

    /// Logs the addition of a product to the cart.
    ///
    /// - Parameters:
    ///   - product: The SimcoeProductConvertible instance.
    ///   - eventProperties: The event properties.
    /// - Returns: A tracking result.
    public func logAddToCart<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) -> TrackingResult {
        let mPProduct = MPProduct(product: product)
        let event = MPCommerceEvent(eventType: .addToCart,
                                    products: [mPProduct],
                                    eventProperties: eventProperties)

        MParticle.sharedInstance().logCommerceEvent(event)

        return .success
    }

    /// Logs the removal of a product from the cart.
    ///
    /// - Parameters:
    ///   - product: The SimcoeProductConvertible instance.
    ///   - eventProperties: The event properties.
    /// - Returns: A tracking result.
    public func logRemoveFromCart<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) -> TrackingResult {
        let mPProduct = MPProduct(product: product)
        let event = MPCommerceEvent(eventType: .removeFromCart,
                                    products: [mPProduct],
                                    eventProperties: eventProperties)

        MParticle.sharedInstance().logCommerceEvent(event)

        return .success
    }

}

// MARK: - CheckoutTracking

extension mParticle: CheckoutTracking {

    /// Tracks a checkout event.
    ///
    /// - Parameters:
    ///   - products: The products.
    ///   - eventProperties: The event properties.
    /// - Returns: A tracking result.
    public func trackCheckoutEvent<T: SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?) -> TrackingResult {
        let mPProducts = products.map { MPProduct(product: $0) }
        let event = MPCommerceEvent(eventType: .checkout,
                                    products: mPProducts,
                                    eventProperties: eventProperties)

        MParticle.sharedInstance().logCommerceEvent(event)

        return .success
    }

}

// MARK: - ErrorLogging

extension mParticle: ErrorLogging {

    /// Logs an error through mParticle.
    ///
    /// It is recommended that you use the `Simcoe.eventData()` function in order to generate the properties
    /// dictionary properly.
    ///
    /// - Parameters:
    ///   - error: The error to log.
    ///   - properties: The properties of the event.
    /// - Returns: A tracking result.
    public func log(error: String, withAdditionalProperties properties: Properties? = nil) -> TrackingResult {
        MParticle.sharedInstance().logError(error, eventInfo: properties)

        return .success
    }

}

// MARK: - EventTracking

extension mParticle: EventTracking {

    /// Tracks an mParticle event.
    ///
    /// Internally, this generates an MPEvent object based on the properties passed in. The event string
    /// passed as the first parameter is delineated as the .name of the MPEvent. As a caller, you are
    /// required to pass in non-nil properties where one of the properties is the MPEventType. Failure
    /// to do so will cause this function to fail.
    ///
    /// It is recommended that you use the `Simcoe.eventData()` function in order to generate the properties
    /// dictionary properly.
    ///
    /// - Parameters:
    ///   - event: The event name to log.
    ///   - properties: The properties of the event.
    /// - Returns: A tracking result.
    public func track(event: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        guard var properties = properties else {
            return .error(message: "Cannot track an event without valid properties.")
        }

        properties[MPEventKeys.name.rawValue] = event

        let event: MPEvent
        do {
            event = try MPEvent.toEvent(usingData: properties)
        } catch let error as MPEventGenerationError {
            return .error(message: error.description)
        } catch {
            return .error(message: mParticle.unknownErrorMessage)
        }

        MParticle.sharedInstance().logEvent(event)

        return .success
    }

}

// MARK: - LifetimeValueTracking

extension mParticle: LifetimeValueTracking {

    /// Tracks the lifetime value.
    ///
    /// - Parameters:
    ///   - key: The lifetime value's identifier.
    ///   - value: The lifetime value.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    public func trackLifetimeValue(_ key: String, value: Any, withAdditionalProperties properties: Properties?) -> TrackingResult {
        guard let value = value as? Double else {
            return .error(message: "Value must map to a Double")
        }

        MParticle.sharedInstance().logLTVIncrease(value, eventName: key, eventInfo: properties)

        return .success
    }

    /// Track the lifetime values.
    ///
    /// - Parameter:
    ///   - attributes: The lifetime attribute values.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    public func trackLifetimeValues(_ attributes: Properties, withAdditionalProperties properties: Properties?) -> TrackingResult {
        attributes.forEach { (key, value) in
            _ = trackLifetimeValue(key, value: value, withAdditionalProperties: properties)
        }

        return .success
    }

}

// MARK: - LocationTracking

extension mParticle: LocationTracking {

    /// Tracks the user's location.
    ///
    /// Internally, this generates an MPEvent object based on the properties passed in. As a result, it is
    /// required that the properties dictionary not be nil and contains keys for .name and .eventType. The latitude
    /// and longitude of the location object passed in will automatically be added to the info dictionary of the MPEvent
    /// object; it is recommended not to include them manually unless there are other properties required to use them.
    ///
    /// It is recommended that you use the `Simcoe.eventData()` function in order to generate the properties
    /// dictionary properly.
    /// - Parameters:
    ///   - location: The location data being tracked.
    ///   - properties: The properties for the MPEvent.
    /// - Returns: A tracking result.
    public func track(location: CLLocation, withAdditionalProperties properties: Properties?) -> TrackingResult {
        var eventProperties = properties ?? Properties() // TODO: Handle Error
        eventProperties["latitude"] = String(location.coordinate.latitude)
        eventProperties["longitude"] = String(location.coordinate.longitude)

        let event: MPEvent
        do {
            event = try MPEvent.toEvent(usingData: eventProperties)
        } catch let error as MPEventGenerationError {
            return .error(message: error.description)
        } catch {
            return .error(message: mParticle.unknownErrorMessage)
        }

        MParticle.sharedInstance().logEvent(event)

        return .success
    }

}

// MARK: - PageViewTracking

extension mParticle: PageViewTracking {

    /// Tracks the page view.
    ///
    /// - Parameters:
    ///   - pageView: The page view to track.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    public func track(pageView: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        MParticle.sharedInstance().logScreen(pageView, eventInfo: properties)

        return .success
    }

}

// MARK: - PurchaseTracking

extension mParticle: PurchaseTracking {

    /// Tracks a purchase event.
    ///
    /// - Parameters:
    ///   - products: The products.
    ///   - eventProperties: The event properties
    /// - Returns: A tracking result.
    public func trackPurchaseEvent<T : SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?) -> TrackingResult {
        let mPProducts = products.map { MPProduct(product: $0) }
        let event = MPCommerceEvent(eventType: .purchase,
                                    products: mPProducts,
                                    eventProperties: eventProperties)

        MParticle.sharedInstance().logCommerceEvent(event)

        return .success
    }

}

// MARK: - TimedEventTracking

extension mParticle: TimedEventTracking {

    /// Starts the timed event.
    ///
    /// - Parameters:
    ///   - event: The event name.
    ///   - properties: The event properties.
    /// - Returns: A tracking result.
    public func start(timedEvent event: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        guard var properties = properties else {
            return .error(message: "Cannot track a timed event without valid properties.")
        }

        properties[MPEventKeys.name.rawValue] = event as String

        let event: MPEvent
        do {
            event = try MPEvent.toEvent(usingData: properties)
        } catch let error as MPEventGenerationError {
            return .error(message: error.description)
        } catch {
            return .error(message: mParticle.unknownErrorMessage)
        }

        MParticle.sharedInstance().beginTimedEvent(event)

        return .success
    }

    /// Stops the timed event.
    ///
    /// - Parameters:
    ///   - event: The event name.
    ///   - properties: The event properties.
    /// - Returns: A tracking result.
    public func stop(timedEvent event: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        guard var properties = properties else {
            return .error(message: "Cannot track a timed event without valid properties.")
        }

        properties[MPEventKeys.name.rawValue] = event as String

        let event: MPEvent
        do {
            event = try MPEvent.toEvent(usingData: properties)
        } catch let error as MPEventGenerationError {
            return .error(message: error.description)
        } catch {
            return .error(message: mParticle.unknownErrorMessage)
        }

        MParticle.sharedInstance().endTimedEvent(event)

        return .success
    }

}

// MARK: - UserAttributeTracking

extension mParticle: UserAttributeTracking {

    /// Sets the User Attribute.
    ///
    /// - Parameters:
    ///   - key: The attribute key to log.
    ///   - value: The attribute value to log.
    /// - Returns: A tracking result.
    public func setUserAttribute(_ key: String, value: Any) -> TrackingResult {
        currentUser?.setUserAttribute(key, value: value)

        return .success
    }

    /// Sets the User Attributes.
    ///
    /// - Parameter attributes: The attribute values to log.
    /// - Returns: A tracking result.
    public func setUserAttributes(_ attributes: Properties) -> TrackingResult {
        attributes.forEach {
            currentUser?.setUserAttribute($0, value: $1)
        }

        return .success
    }

}

// MARK: - ViewDetailLogging

extension mParticle: ViewDetailLogging {

    /// Logs the action of viewing a product's details.
    ///
    /// - Parameters:
    ///   - product: The SimcoeProductConvertible instance.
    ///   - eventProperties: The event properties.
    /// - Returns: A tracking result.
    public func logViewDetail<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) -> TrackingResult {
        let mPProduct = MPProduct(product: product)
        let event = MPCommerceEvent(eventType: .viewDetail,
                                    products: [mPProduct],
                                    eventProperties: eventProperties)

        MParticle.sharedInstance().logCommerceEvent(event)

        return .success
    }

}
