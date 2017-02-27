//
//  LifetimeValueTrackingFake.swift
//  Simcoe
//
//  Created by Yoseob Lee on 2/27/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class LifetimeValueTrackingFake: LifetimeValueTracking {

    let name = "Lifetime Value Tracking [Fake]"

    var lifetimeValueCallCount = 0

    func trackLifetimeValue(_ key: String, value: Any, withAdditionalProperties properties: Properties?) -> TrackingResult {
        lifetimeValueCallCount += 1
        return .success
    }

    func trackLifetimeValues(_ attributes: Properties, withAdditionalProperties properties: Properties?) -> TrackingResult {
        attributes.forEach { _ in
            lifetimeValueCallCount += 1
        }
        return .success
    }

}
