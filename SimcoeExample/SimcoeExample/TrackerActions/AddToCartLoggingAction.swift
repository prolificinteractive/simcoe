//
//  AddToCartLoggingAction.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/23/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe

internal final class AddToCartLoggingAction: TrackerAction {
    
    var name: String {
        return "Track Add to Cart Logging"
    }
    
    private var engine: AnalyticsEngine
    
    init(engine: AnalyticsEngine) {
        self.engine = engine
    }
    
    func isActionAvailable(provider: AnalyticsTracking) -> Bool {
        return provider is CartLogging
    }
    
    func track() {
        engine.logAddToCart(SampleProduct(), eventProperties: defaultProperties)
    }
}
