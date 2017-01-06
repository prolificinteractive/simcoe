//
//  PageViewTrackingFake.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class PageViewTrackingFake: PageViewTracking, Failable {

    let name = "Page View Tracking [Fake]"

    var shouldFail = false

    var pageViewTrackCount = 0

    func track(pageView: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        pageViewTrackCount += 1

        if shouldFail {
           return .error(message: "Error")
        }

        return .success
    }
}
