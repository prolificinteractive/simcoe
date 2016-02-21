//
//  PageViewTrackingFake.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class PageViewTrackingFake: PageViewTracking {

    let name = "Page View Tracking [Fake]"

    var pageViewTrackCount = 0

    func trackPageView(pageView: String, withAdditionalProperties properties: Properties?) {
        pageViewTrackCount += 1
    }
}
