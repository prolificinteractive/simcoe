//
//  UserAttributeTracking.swift
//  Simcoe
//
//  Created by John Lin on 5/17/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// Defines functionality for logging errors to analytics.
public protocol UserAttributeTracking: AnalyticsTracking {

    /// Sets the User Attribute.
    ///
    /// - Parameters:
    ///   - key: The attribute key to log.
    ///   - value: The attribute value to log.
    /// - Returns: A tracking result.
    func setUserAttribute(_ key: String, value: Any) -> TrackingResult

    /// Sets the User Attributes.
    ///
    /// - Parameter attributes: The attribute values to log.
    /// - Returns: A tracking result.
    func setUserAttributes(_ attributes: Properties) -> TrackingResult

}
