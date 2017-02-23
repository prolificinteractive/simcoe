//
//  UserAttributeTrackingAction.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/23/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe

internal final class UserAttributeTrackingAction: TrackerAction {
    
    var name: String {
        return "Track Set User Attribute"
    }
    
    private var engine: AnalyticsEngine
    
    init(engine: AnalyticsEngine) {
        self.engine = engine
    }
    
    func isActionAvailable(provider: AnalyticsTracking) -> Bool {
        return provider is UserAttributeTracking
    }
    
    func track() {
        engine.setUserAttribute("Logged In Type", value: "Email" as AnyObject)
    }
}

