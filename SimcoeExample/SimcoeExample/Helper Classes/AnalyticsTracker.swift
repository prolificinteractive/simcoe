//
//  AnalyticsTracker.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe

internal class AnalyticsTracker {
    
    var providers: [AnalyticsTracking]
    
    var actions: [TrackerAction]
    
    var name: String
    
    init(providers: [AnalyticsTracking], actions: [TrackerAction], name: String) {
        self.providers = providers
        self.actions = actions
        self.name = name
    }
}
