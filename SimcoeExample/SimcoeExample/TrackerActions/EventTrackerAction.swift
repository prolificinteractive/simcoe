//
//  EventTrackerAction.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe
import mParticle_Apple_SDK

internal class EventTrackerAction: TrackerAction {
    
    var name: String {
        return "Track Event"
    }
    
    private var engine: AnalyticsEngine
    
    init(engine: AnalyticsEngine) {
        self.engine = engine
    }
    
    func isActionAvailable(provider: AnalyticsTracking) -> Bool {
        return provider is EventTracking
    }
    
    func track() {
        var eventDataProperties: Properties = MPEvent.eventData(type: .other, name: "")
        eventDataProperties["Location"] = "Tracker Page"
        
        engine.track(event: "Tapped Track Event", withAdditionalProperties: eventDataProperties)
    }
}
