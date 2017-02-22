//
//  TrackerAction.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe

internal protocol TrackerAction {
    
    var name: String { get }
    
    func isActionAvailable(provider: AnalyticsTracking) -> Bool
    
    func track()
    
    func isContainedIn(actions: [TrackerAction]) -> Bool
}

extension TrackerAction {
    
    func isContainedIn(actions: [TrackerAction]) -> Bool {
        return actions.contains(where: { (arrayAction) -> Bool in
            return name == arrayAction.name
        })
    }
}
