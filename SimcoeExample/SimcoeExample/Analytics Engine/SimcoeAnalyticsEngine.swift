//
//  SimcoeAnalyticsEngine.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe
import CoreLocation

internal class SimcoeAnalyticsEngine: AnalyticsEngine {
    
    func run(with providers: [AnalyticsTracking]) {
        Simcoe.run(with: providers)
    }
    
    func track(event: String, withAdditionalProperties properties: Properties?) {
        Simcoe.track(event: event, withAdditionalProperties: properties)
    }
    
    func trackLifetimeIncrease(byAmount amount: Double,
                               forItem item: String?,
                               withAdditionalProperties properties: Properties?) {
        
        Simcoe.trackLifetimeIncrease(byAmount: amount, forItem: item, withAdditionalProperties: properties)
    }
    
    func track(location: CLLocation, withAdditionalProperties properties: Properties?) {
        Simcoe.track(location: location, withAdditionalProperties: properties)
    }
    
    func track(pageView: String, withAdditionalProperties properties: Properties?) {
        Simcoe.track(pageView: pageView, withAdditionalProperties: properties)
    }
}
