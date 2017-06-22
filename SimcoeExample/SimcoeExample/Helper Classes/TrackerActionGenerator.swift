//
//  TrackerActionGenerator.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/23/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe

internal final class TrackerActionGenerator: ActionGenerator {
    
    private var engine: AnalyticsEngine
    
    private var availableTrackerActions: [TrackerAction]
    
    init(engine: AnalyticsEngine, availableTrackerActions: [TrackerAction]) {
        self.engine = engine
        self.availableTrackerActions = availableTrackerActions
    }
    
    func trackerActions(providers: [AnalyticsTracking]) -> [TrackerAction] {
        var actions: [TrackerAction] = []
        
        for provider in providers {
            for action in availableTrackerActions {
                if action.isActionAvailable(provider: provider) == true &&
                    action.isContainedIn(actions: actions) == false {
                    
                    actions.append(action)
                }
            }
        }
        
        return actions
    }
}
