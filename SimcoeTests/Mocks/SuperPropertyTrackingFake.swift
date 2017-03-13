//
//  SuperPropertyTrackingFake.swift
//  Simcoe
//
//  Created by Yoseob Lee on 2/27/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class SuperPropertyTrackingFake: SuperPropertyTracking {

    let name = "Super Property Tracking [Fake]"

    var superPropertyEventCount = 0

    func set(superProperties: Properties) -> TrackingResult {
        superPropertyEventCount += 1
        return .success
    }

    func unset(superProperty: String) -> TrackingResult {
        superPropertyEventCount += 1
        return .success
    }

    func clearSuperProperties() -> TrackingResult {
        superPropertyEventCount += 1
        return .success
    }

}
