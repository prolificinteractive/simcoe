//
//  LocationTrackingFake.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation
@testable import Simcoe

internal final class LocationTrackingFake: LocationTracking {

    let name = "Location Tracking [Fake]"

    var trackLocationCallCount = 0

    func trackLocation(location: CLLocation, withAdditionalProperties properties: Properties?) {
        trackLocationCallCount += 1
    }

}
