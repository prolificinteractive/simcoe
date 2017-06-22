//
//  CheckoutTrackingAction.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/23/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe

internal final class CheckoutTrackingAction: TrackerAction {
    
    var name: String {
        return "Track Checkout Event"
    }
    
    private var engine: AnalyticsEngine
    
    init(engine: AnalyticsEngine) {
        self.engine = engine
    }
    
    func isActionAvailable(provider: AnalyticsTracking) -> Bool {
        return provider is CheckoutTracking
    }
    
    func track() {
        engine.trackCheckoutEvent([SampleProduct()], eventProperties: defaultProperties)
    }
}
