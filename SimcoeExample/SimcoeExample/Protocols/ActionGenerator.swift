//
//  ActionGenerator.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/23/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe

internal protocol ActionGenerator {
    
    func trackerActions(providers: [AnalyticsTracking]) -> [TrackerAction]
}
