//
//  ErrorLogging.swift
//  Simcoe
//
//  Created by John Lin on 5/17/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// Defines methods for logging errors to analytics.
public protocol ErrorLogging: AnalyticsTracking {

    /// Logs the error with optional additional properties.
    ///
    /// - Parameters:
    ///   - error: The error to log.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    func log(error: String, withAdditionalProperties properties: Properties?) -> TrackingResult
    
}
