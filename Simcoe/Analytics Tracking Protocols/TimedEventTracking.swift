//
//  TimedEventTracking.swift
//  Simcoe
//
//  Created by Yoseob Lee on 2/27/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/// Defines methods for tracking timed events.
public protocol TimedEventTracking: AnalyticsTracking {

    /// Starts the timed event.
    ///
    /// - Parameters:
    ///   - event: The event name.
    ///   - eventProperties: The event properties.
    /// - Returns: A tracking result.
    func start(timedEvent event: String, withAdditionalProperties properties: Properties?) -> TrackingResult

    /// Stops the timed event.
    ///
    /// - Parameters:
    ///   - event: The event name.
    ///   - eventProperties: The event properties.
    /// - Returns: A tracking result.
    func stop(timedEvent event: String, withAdditionalProperties properties: Properties?) -> TrackingResult

}
