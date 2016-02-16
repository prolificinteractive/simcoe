//
//  LocationTracking.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation

public protocol LocationTracking: AnalyticsTracking {

    func trackLocation(location: CLLocation)
    
}