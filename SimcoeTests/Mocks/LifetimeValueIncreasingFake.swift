//
//  LifetimeValueIncreasingFake.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class LifetimeValueIncreasingFake: LifetimeValueIncreasing {

    let name = "Lifetime Value Increasing [Fake]"

    var lifetimeValueCallCount = 0

    func increment(property: String?, value: Double, withAdditionalProperties properties: Properties?) -> TrackingResult {
        lifetimeValueCallCount += 1

        return .success
    }

    func increment(properties: Properties, withAdditionalProperties data: Properties?) -> TrackingResult {
        properties.forEach { _ in
            lifetimeValueCallCount += 1
        }

        return .success
    }

}
