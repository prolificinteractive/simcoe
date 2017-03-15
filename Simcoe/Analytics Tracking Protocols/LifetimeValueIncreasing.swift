//
//  LifetimeValueIncreasing.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// Defines methods for increasing a lifetime value of an analytics key.
public protocol LifetimeValueIncreasing: AnalyticsTracking {

    /// Increments the property.
    ///
    /// - Parameters:
    ///   - property: The property.
    ///   - value: The amount to increment the property by.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    func increment(property: String?, by value: Double, withAdditionalProperties properties: Properties?) -> TrackingResult

    /// Increments the properties.
    ///
    /// - Parameters:
    ///   - properties: The properties.
    ///   - data: The optional additional properties.
    /// - Returns: A tracking result.
    func increment(properties: Properties, withAdditionalProperties data: Properties?) -> TrackingResult

}
