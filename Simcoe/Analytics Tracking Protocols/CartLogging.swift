//
//  CartLogging.swift
//  Simcoe
//
//  Created by Michael Campbell on 9/9/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 *  Defines functionality for logging cart actions.
 */
public protocol CartLogging: AnalyticsTracking {

    /// Logs the addition of a product to the cart.
    ///
    /// - parameter product:         The SimcoeProductConvertible instance.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    func logAddToCart<T: SimcoeProductConvertible>(product: T, eventProperties: Properties?) -> TrackingResult

    /// Logs the removal of a product from the cart.
    ///
    /// - parameter product:         The SimcoeProductConvertible instance.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    func logRemoveFromCart<T: SimcoeProductConvertible>(product: T, eventProperties: Properties?) -> TrackingResult
    
}
