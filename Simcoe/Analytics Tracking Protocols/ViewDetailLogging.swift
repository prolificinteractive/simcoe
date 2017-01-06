//
//  ViewDetailLogging.swift
//  Simcoe
//
//  Created by Yoseob Lee on 11/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 *  Defines functionality for logging view detail actions.
 */
public protocol ViewDetailLogging: AnalyticsTracking {

    /// Logs the action of viewing a product's details.
    ///
    /// - parameter product: The SimcoeProductConvertible instance.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A tracking result.
    func logViewDetail<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) -> TrackingResult

}
