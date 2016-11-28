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

    /**
     Tracks the given event with optional additional properties.

     - parameter event:      The event to tack.
     - parameter properties: The optional additional properties.

     - returns: A tracking result.
     */
    func trackEvent(event: String, withAdditionalProperties properties: Properties?) -> TrackingResult

}
