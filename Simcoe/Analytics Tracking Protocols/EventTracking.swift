//
//  EventTracking.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 Defines methods for tracking analytics events.
 */
public protocol EventTracking: AnalyticsTracking {

    /// Tracks the given event with optional additional properties.
    ///
    /// - Parameters:
    ///   - event: The event to track.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    func track(event: String, withAdditionalProperties properties: Properties?) -> TrackingResult

}
