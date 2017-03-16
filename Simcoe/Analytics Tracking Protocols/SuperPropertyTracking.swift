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
    /// - Parameter superProperties: The super properties.
    /// - Returns: A tracking result.
    func set(superProperties: Properties) -> TrackingResult

    /// Unsets the super property.
    ///
    /// - Parameter superProperty: The super property.
    /// - Returns: A tracking result.
    func unset(superProperty: String) -> TrackingResult

    /// Clears all currently set super properties.
    ///
    /// - Returns: A tracking result.
    func clearSuperProperties() -> TrackingResult

}
