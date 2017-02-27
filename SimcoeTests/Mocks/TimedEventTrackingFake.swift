//
//  TimedEventTrackingFake.swift
//  Simcoe
//
//  Created by Yoseob Lee on 2/27/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class TimedEventTrackingFake: TimedEventTracking {

    let name = "Timed Event Tracking [Fake]"

    var trackTimedEventCallCount = 0

    func start(timedEvent event: String, eventProperties: Properties?) -> TrackingResult {
        trackTimedEventCallCount += 1
        return .success
    }

    func stop(timedEvent event: String, eventProperties: Properties?) -> TrackingResult {
        trackTimedEventCallCount += 1
        return .success
    }

}
