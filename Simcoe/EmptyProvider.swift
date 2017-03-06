//
//  EmptyProvider.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/22/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation

/// The empty provider.
internal final class EmptyProvider {

    /// The name of the tracker.
    let name = "Analytics"

}

// MARK: - CartLogging

extension EmptyProvider: CartLogging {

    /// Logs the addition of a product to the cart.
    ///
    /// - Parameters:
    ///   - product: The SimcoeProductConvertible instance.
    ///   - eventProperties: The event properties.
    /// - Returns: A tracking result.
    func logAddToCart<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) -> TrackingResult {
        return .success
    }

    /// Logs the removal of a product from the cart.
    ///
    /// - Parameters:
    ///   - product: The SimcoeProductConvertible instance.
    ///   - eventProperties: The event properties.
    /// - Returns: A tracking result.
    func logRemoveFromCart<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) -> TrackingResult {
        return .success
    }
}

// MARK: - CheckoutTracking

extension EmptyProvider: CheckoutTracking {

    /// Tracks a checkout event.
    ///
    /// - Parameters:
    ///   - products: The products.
    ///   - eventProperties: The event properties.
    /// - Returns: A tracking result.
    func trackCheckoutEvent<T: SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?) -> TrackingResult {
        return .success
    }

}

// MARK: - ErrorLogging

extension EmptyProvider: ErrorLogging {

    /// Logs the error with optional additional properties.
    ///
    /// - Parameters:
    ///   - error: The error to log.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    func log(error: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        return .success
    }
    
}

// MARK: - EventTracking

extension EmptyProvider: EventTracking {

    /// Tracks the given event with optional additional properties.
    ///
    /// - Parameters:
    ///   - event: The event to track.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    func track(event: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        return .success
    }

}

// MARK: - LifetimeValueIncreasing

extension EmptyProvider: LifetimeValueIncreasing {

    /// Increases the lifetime value of the key by the specified amount.
    ///
    /// - Parameters:
    ///   - amount: The amount to increase that lifetime value for.
    ///   - item: The optional item to extend.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    func increaseLifetimeValue(byAmount amount: Double, forItem item: String?, withAdditionalProperties properties: Properties?) -> TrackingResult {
        return .success
    }

}

// MARK: - LocationTracking

extension EmptyProvider: LocationTracking {

    /// Tracks location.
    ///
    /// - Parameters:
    ///   - location: The location to track.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    func track(location: CLLocation, withAdditionalProperties properties: Properties?) -> TrackingResult {
        return .success
    }

}

// MARK: - PageViewTracking

extension EmptyProvider: PageViewTracking {

    /// Tracks the page view.
    ///
    /// - Parameters:
    ///   - pageView: The page view to track.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    func track(pageView: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        return .success
    }

}

// MARK: - PurchaseTracking

extension EmptyProvider: PurchaseTracking {

    /// Tracks a purchase event.
    ///
    /// - Parameters:
    ///   - products: The products.
    ///   - eventProperties: The event properties
    /// - Returns: A tracking result.
    func trackPurchaseEvent<T : SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?) -> TrackingResult {
        return .success
    }
    
}

// MARK: - UserAttributeTracking

extension EmptyProvider: UserAttributeTracking {

    /// Sets the User Attribute.
    ///
    /// - Parameters:
    ///   - key: The attribute key to log.
    ///   - value: The attribute value to log.
    /// - Returns: A tracking result.
    func setUserAttribute(_ key: String, value: Any) -> TrackingResult {
        return .success
    }
    
}

// MARK: - ViewDetailLogging

extension EmptyProvider: ViewDetailLogging {

    /// Logs the action of viewing a product's details.
    ///
    /// - Parameters:
    ///   - product: The SimcoeProductConvertible instance.
    ///   - eventProperties: The event properties.
    /// - Returns: A tracking result.
    func logViewDetail<T : SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) -> TrackingResult {
        return .success
    }
    
}
