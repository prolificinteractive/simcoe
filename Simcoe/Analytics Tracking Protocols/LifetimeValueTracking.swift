//
//  LifetimeValueTracking.swift
//  Simcoe
//
//  Created by Yoseob Lee on 2/27/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/// Defines methods for tracking lifetime values.
public protocol LifetimeValueTracking: AnalyticsTracking {

    /// Tracks the lifetime value.
    ///
    /// - Parameters:
    ///   - key: The lifetime value's identifier.
    ///   - value: The lifetime value.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    func trackLifetimeValue(_ key: String, value: Any, withAdditionalProperties properties: Properties?) -> TrackingResult

    /// Track the lifetime values.
    ///
    /// - Parameter:
    ///   - attributes: The lifetime attribute values.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    func trackLifetimeValues(_ attributes: Properties, withAdditionalProperties properties: Properties?) -> TrackingResult

}
