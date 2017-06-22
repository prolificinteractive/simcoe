//
//  AnalyticsProviders.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/23/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe

internal class AnalyticsProviders {
    
    var trackers: [AnalyticsTracker] = []
    
    private let availableActions: [TrackerAction]
    
    private var engine: AnalyticsEngine
    
    init(engine: AnalyticsEngine, availableActions: [TrackerAction]) {
        self.engine = engine
        self.availableActions = availableActions
    }
    
    func addTracker(name: String, providers: [AnalyticsTracking]) {
        guard !providers.isEmpty else {
            self.trackers.append(AnalyticsTracker(providers: providers, actions: availableActions, name: name))
            return
        }
        
        let actionGenerator = TrackerActionGenerator(engine: engine, availableTrackerActions: availableActions)
        let actions = actionGenerator.trackerActions(providers: providers)
        
        self.trackers.append(AnalyticsTracker(providers: providers, actions: actions, name: name))
    }
}
