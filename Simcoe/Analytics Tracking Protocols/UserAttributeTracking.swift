//
//  UserAttributeTracking.swift
//  Simcoe
//
//  Created by John Lin on 5/17/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 Defines functionality for logging errors to analytics.
 */
public protocol UserAttributeTracking: AnalyticsTracking {
    
    /**
     Sets the User Attribute.
     
     - parameter key:      The attribute key to log.
     - parameter value:    The attribute value to log.
     
     - returns: A tracking result.
     */
    func setUserAttribute(_ key: String, value: Any) -> TrackingResult
    
}
