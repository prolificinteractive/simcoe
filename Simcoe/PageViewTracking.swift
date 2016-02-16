//
//  PageViewTracking.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
Defines functionality for tracking page views.
*/
public protocol PageViewTracking: AnalyticsTracking {

    /**
     Tracks the page view.

     - parameter pageView: The page view to track.
     */
    func trackPageView(pageView: String)
    
}