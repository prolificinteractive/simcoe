//
//  RecorderTests.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import XCTest
@testable import Simcoe

class RecorderTests: XCTestCase {

    var simcoe: Simcoe!

    override func setUp() {
        simcoe = Simcoe()
    }

    func test_that_it_records_events() {
        let tracker = PageViewTrackingFake()
        simcoe.providers = [tracker]
        let expectation = 1

        simcoe.trackPageView("1234")

        XCTAssertEqual(expectation, simcoe.recorder.events.count,
            "Expected result = \(expectation); got \(simcoe.recorder.events.count)")
    }

}