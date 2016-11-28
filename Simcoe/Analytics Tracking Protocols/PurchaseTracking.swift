//
//  PurchaseTracking.swift
//  Simcoe
//
//  Created by Yoseob Lee on 11/15/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 *  Defines functionality for tracking purchase actions.
 */
public protocol PurchaseTracking: AnalyticsTracking {

    /// Tracks a purchase event.
    ///
    /// - parameter products:        The products.
    /// - parameter eventProperties: The event properties
    ///
    /// - returns: A tracking result.
    func trackPurchaseEvent<T: SimcoeProductConvertible>(products: [T], eventProperties: Properties?) -> TrackingResult

}
