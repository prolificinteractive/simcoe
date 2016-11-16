//
//  EmptyProvider.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/22/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation

internal final class EmptyProvider {

    let name = "Analytics"

}

extension EmptyProvider: ViewDetailLogging {

    /// Logs the action of viewing a product's details.
    ///
    /// - parameter product: The SimcoeProductConvertible instance.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    func logViewDetail<T : SimcoeProductConvertible>(product: T, eventProperties: Properties?) -> TrackingResult {
        return .Success
    }

}

extension EmptyProvider: CartLogging {

    /// Logs the addition of a product to the cart.
    ///
    /// - parameter product:         The SimcoeProductConvertible instance.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    func logAddToCart<T: SimcoeProductConvertible>(product: T, eventProperties: Properties?) -> TrackingResult {
        return .Success
    }

    /// Logs the removal of a product from the cart.
    ///
    /// - parameter product:         The SimcoeProductConvertible instance.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    func logRemoveFromCart<T: SimcoeProductConvertible>(product: T, eventProperties: Properties?) -> TrackingResult {
        return .Success
    }
}

extension EmptyProvider: CheckoutTracking {

    /// Tracks a checkout event.
    ///
    /// - parameter products:        The products.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    func trackCheckoutEvent<T: SimcoeProductConvertible>(products: [T], eventProperties: Properties?) -> TrackingResult {
        return .Success
    }

}

extension EmptyProvider: PurchaseTracking {

    /// Tracks a purchase event.
    ///
    /// - parameter products:        The products.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    func trackPurchaseEvent<T : SimcoeProductConvertible>(products: [T], eventProperties: Properties?) -> TrackingResult {
        return .Success
    }

}

extension EmptyProvider: ErrorLogging {

    func logError(error: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        return .Success
    }
    
}

extension EmptyProvider: EventTracking {

    func trackEvent(event: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        return .Success
    }

}

extension EmptyProvider: LifetimeValueIncreasing {

    func increaseLifetimeValue(byAmount amount: Double, forItem item: String?, withAdditionalProperties properties: Properties?) -> TrackingResult {
        return .Success
    }

}

extension EmptyProvider: LocationTracking {

    func trackLocation(location: CLLocation, withAdditionalProperties properties: Properties?) -> TrackingResult {
        return .Success
    }

}

extension EmptyProvider: PageViewTracking {

    func trackPageView(pageView: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        return .Success
    }

}

extension EmptyProvider: UserAttributeTracking {
    
    func setUserAttribute(key: String, value: AnyObject) -> TrackingResult {
        return .Success
    }
    
}
