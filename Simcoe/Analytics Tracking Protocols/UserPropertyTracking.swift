//
//  UserPropertyTracking.swift
//  Simcoe
//
//  Created by Jonathan Samudio on 2/27/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/// Defines methods for tracking user properties.
public protocol UserPropertyTracking: AnalyticsTracking {

    /// Sets the user properties.
    ///
    /// - Parameter properties: The user properties.
    /// - Returns: A tracking result.
    func set(userProperties properties: Properties) -> TrackingResult

    /// Sets the user alias.
    ///
    /// - Parameter userId: The user alias.
    /// - Returns: A tracking result.
    func set(userAlias userId: String) -> TrackingResult

    /// Increments the user property.
    ///
    /// - Parameters:
    ///   - property: The user property.
    ///   - value: The amonut to increment the user property by.
    /// - Returns: A tracking result.
    func increment(userProperty property: String, value: Double) -> TrackingResult

}
