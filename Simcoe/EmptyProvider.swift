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

extension EmptyProvider: CartLogging {

    func logAddToCart(productName: String, productId: String, quantity: Int, price: Double?, withAdditionalProperties additionalProperties: Properties?) -> TrackingResult {
        return .Success
    }

    func logRemoveFromCart(productName: String, productId: String, quantity: Int, price: Double?, withAdditionalProperties properties: Properties?) -> TrackingResult {
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
