//
//  LocationTrackingAction.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe
import CoreLocation

internal class LocationTrackingAction: TrackerAction {
    
    var name: String {
        return "Track Location"
    }
    
    private var engine: AnalyticsEngine
    
    init(engine: AnalyticsEngine) {
        self.engine = engine
    }
    
    func isActionAvailable(provider: AnalyticsTracking) -> Bool {
        return provider is LocationTracking
    }
    
    func track() {
        let location = CLLocation(latitude: 40.7128, longitude: 74.0059)
        engine.track(location: location, withAdditionalProperties: defaultProperties)
    }
}
