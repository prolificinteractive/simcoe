//
//  CheckoutTracking.swift
//  Simcoe
//
//  Created by Michael Campbell on 9/26/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// Defines functionality for tracking checkout actions.
public protocol CheckoutTracking: AnalyticsTracking {

    /// Tracks a checkout event.
    ///
    /// - Parameters:
    ///   - products: The products.
    ///   - eventProperties: The event properties.
    /// - Returns: A tracking result.
    func trackCheckoutEvent<T: SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?) -> TrackingResult

}
