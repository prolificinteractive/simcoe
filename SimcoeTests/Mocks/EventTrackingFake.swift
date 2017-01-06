//
//  EventTrackingFake.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class EventTrackingFake: EventTracking {

    let name = "Event Tracking [Fake]"

    var trackEventCallCount = 0

    func track(event: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        trackEventCallCount += 1
        return .success
    }

}
