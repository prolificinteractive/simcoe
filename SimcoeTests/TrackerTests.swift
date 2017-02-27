//
//  RecorderTests.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import XCTest
@testable import Simcoe

class TrackerTests: XCTestCase {

    var simcoe: Simcoe!
    var outputSource: OutputFake!

    override func setUp() {
        outputSource = OutputFake()
        simcoe = Simcoe(tracker: Tracker(outputSources: [outputSource]))
    }

    func test_that_it_records_events() {
        let tracker = PageViewTrackingFake()
        simcoe.providers = [tracker]
        let expectation = 1

        simcoe.track(pageView: "1234")

        XCTAssertEqual(expectation, simcoe.tracker.events.count,
            "Expected result = \(expectation); got \(simcoe.tracker.events.count)")
    }

    func test_that_it_does_not_write_when_option_none() {
        simcoe.providers = [PageViewTrackingFake(), PageViewTrackingFake(), PageViewTrackingFake()]
        simcoe.tracker.outputOption = .none
        let expectation = 0

        simcoe.track(pageView: "1234")

        XCTAssertEqual(expectation, outputSource.printCallCount,
            "Expected result = \(expectation); got \(outputSource.printCallCount)")
    }

    func test_that_it_writes_to_output_once_when_option_simple() {
        simcoe.providers = [PageViewTrackingFake(), PageViewTrackingFake(), PageViewTrackingFake()]
        simcoe.tracker.outputOption = .simple
        let expectation = 1

        simcoe.track(pageView: "1234")

        XCTAssertEqual(expectation, outputSource.printCallCount,
            "Expected result = \(expectation); got \(outputSource.printCallCount)")
    }

    func test_that_it_writes_to_output_for_each_provider_when_option_verbose() {
        simcoe.providers = [PageViewTrackingFake(), PageViewTrackingFake(), PageViewTrackingFake()]
        simcoe.tracker.outputOption = .verbose
        let expectation = simcoe.providers.count

        simcoe.track(pageView: "1234")

        XCTAssertEqual(expectation, outputSource.printCallCount,
            "Expected result = \(expectation); got \(outputSource.printCallCount)")
    }

    func test_that_it_does_not_log_errors_when_option_suppress() {
        let pageViewTracker = PageViewTrackingFake()
        pageViewTracker.shouldFail = true
        simcoe.providers = [pageViewTracker]
        simcoe.tracker.errorOption = .suppress
        let expectation = 0

        simcoe.track(pageView: "page view test")

        XCTAssertEqual(expectation, outputSource.printCallCount,
            "Expected result = \(expectation); got \(outputSource.printCallCount)")
    }

    func test_that_it_logs_errors_when_option_default() {
        let pageViewTracker = PageViewTrackingFake()
        pageViewTracker.shouldFail = true

        simcoe.providers = [pageViewTracker]
        simcoe.tracker.errorOption = .default
        let expectation = 1

        simcoe.track(pageView: "1234")

        XCTAssertEqual(expectation, outputSource.printCallCount,
             "Expected result = \(expectation); got \(outputSource.printCallCount)")
    }

    func test_that_it_logs_one_error_per_provider_when_option_default() {
        let pageViewTrackers = [PageViewTrackingFake(), PageViewTrackingFake(), PageViewTrackingFake()]
        for tracker in pageViewTrackers {
            tracker.shouldFail = true
        }

        simcoe.providers = pageViewTrackers.map({ $0 as AnalyticsTracking }) // Cast fixes weird array assignment crash
        simcoe.tracker.errorOption = .default
        let expectation = pageViewTrackers.count

        simcoe.track(pageView: "1234")

        XCTAssertEqual(expectation, outputSource.printCallCount,
            "Expected result = \(expectation); got \(outputSource.printCallCount)")
    }

}
