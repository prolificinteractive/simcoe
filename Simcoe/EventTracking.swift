//
//  EventTracking.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

public protocol EventTracking: AnalyticsTracking {

    func trackEvent(event: String, withAdditionalProperties properties: [String: String]?)
    
}