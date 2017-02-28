//
//  SuperPropertyTracking.swift
//  Simcoe
//
//  Created by Jonathan Samudio on 2/27/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/// Defines methods for tracking the super property.
public protocol SuperPropertyTracking: AnalyticsTracking {

    /// Sets the super properties.
    ///
    /// - Parameter properties: The super properties.
    /// - Returns: A tracking result.
    func set(superProperties properties: Properties) -> TrackingResult


    /// Increments the super property.
    ///
    /// - Parameters:
    ///   - property: The super property.
    ///   - value: The amount to increment the super property by.
    /// - Returns: A tracking result.
    func increment(superProperty property: String, value: Double) -> TrackingResult

}
