//
//  AvailableTrackers.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/23/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

internal class AvailableTrackers {
    
    lazy var actions: [TrackerAction] = {
        return [EventTrackerAction(engine: self.engine),
                LocationTrackingAction(engine: self.engine),
                LifetimeValueIncreasingAction(engine: self.engine),
                PageViewTrackingAction(engine: self.engine),
                AddToCartLoggingAction(engine: self.engine),
                RemoveFromCartAction(engine: self.engine),
                CheckoutTrackingAction(engine: self.engine),
                ErrorLoggingAction(engine: self.engine),
                PurchaseTrackingAction(engine: self.engine),
                UserAttributeTrackingAction(engine: self.engine),
                ViewDetailLoggingAction(engine: self.engine)]
    }()
    
    private var engine: AnalyticsEngine
    
    init(engine: AnalyticsEngine) {
        self.engine = engine
    }
}
