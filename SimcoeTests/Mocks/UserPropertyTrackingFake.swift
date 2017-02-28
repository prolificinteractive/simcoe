//
//  UserPropertyTrackingFake.swift
//  Simcoe
//
//  Created by Yoseob Lee on 2/27/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class UserPropertyTrackingFake: UserPropertyTracking {

    let name = "User Property Tracking [Fake]"

    var userPropertyCallCount = 0

    func set(userProperties properties: Properties) -> TrackingResult {
        userPropertyCallCount += 1
        return .success
    }

    func set(userAlias userId: String) -> TrackingResult {
        userPropertyCallCount += 1
        return .success
    }

    func increment(userProperty property: String, value: Double) -> TrackingResult {
        userPropertyCallCount += 1
        return .success
    }

}
