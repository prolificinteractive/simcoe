//
//  AnalyticsEngine.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe
import CoreLocation

internal protocol AnalyticsEngine {
    
    func run(with providers: [AnalyticsTracking])
    
    func track(event: String, withAdditionalProperties properties: Properties?)
    
    func trackLifetimeIncrease(byAmount amount: Double,
                               forItem item: String?,
                               withAdditionalProperties properties: Properties?)
    
    func track(location: CLLocation, withAdditionalProperties properties: Properties?)
    
    func track(pageView: String, withAdditionalProperties properties: Properties?)
}
