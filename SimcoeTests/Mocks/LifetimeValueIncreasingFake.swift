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

    func increaseLifetimeValue(byAmount amount: Double,
        forItem item: String?, withAdditionalProperties properties: Properties?) {
            lifetimeValueCallCount += 1
    }

}
