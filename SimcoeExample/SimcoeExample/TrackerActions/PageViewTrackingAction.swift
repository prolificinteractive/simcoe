//
//  PageViewTrackingAction.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe
import CoreLocation

internal class PageViewTrackingAction: TrackerAction {
    
    var name: String {
        return "Track Page View"
    }
    
    private var engine: AnalyticsEngine
    
    init(engine: AnalyticsEngine) {
        self.engine = engine
    }
    
    func isActionAvailable(provider: AnalyticsTracking) -> Bool {
        return provider is PageViewTracking
    }
    
    func track() {
        let properties: Properties = ["Location" : "Tracker Page"]
        engine.track(pageView: "Tracker Selection Page View", withAdditionalProperties: properties)
    }
}
