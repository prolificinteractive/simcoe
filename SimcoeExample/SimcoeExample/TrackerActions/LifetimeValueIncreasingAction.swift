//
//  LifetimeValueIncreasingAction.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe

internal class LifetimeValueIncreasingAction: TrackerAction {
    
    var name: String {
        return "Track Lifetime Value Increase"
    }
    
    private var engine: AnalyticsEngine
    
    init(engine: AnalyticsEngine) {
        self.engine = engine
    }
    
    func isActionAvailable(provider: AnalyticsTracking) -> Bool {
        return provider is LifetimeValueIncreasing
    }
    
    func track() {
        engine.trackLifetimeIncrease(byAmount: 1,
                                     forItem: "Track Lifetime Value Tapped",
                                     withAdditionalProperties: defaultProperties)
    }
}
