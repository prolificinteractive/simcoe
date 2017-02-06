//
//  PurchaseTracking.swift
//  Simcoe
//
//  Created by Yoseob Lee on 11/15/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// Defines functionality for tracking purchase actions.
public protocol PurchaseTracking: AnalyticsTracking {

    /// Tracks a purchase event.
    ///
    /// - Parameters:
    ///   - products: The products.
    ///   - eventProperties: The event properties
    /// - Returns: A tracking result.
    func trackPurchaseEvent<T: SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?) -> TrackingResult

}
