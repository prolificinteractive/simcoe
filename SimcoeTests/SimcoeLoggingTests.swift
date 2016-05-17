//
//  SimcoeTests.swift
//  SimcoeTests
//
//  Created by Christopher Jones on 2/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation
import XCTest
@testable import Simcoe

class SimcoeLoggingTests: XCTestCase {

    var simcoe: Simcoe!

    override func setUp() {
        super.setUp()

        simcoe = Simcoe(tracker: Tracker())
    }

    func test_that_it_logs_page_views_to_providers() {
        let pageViewTracker = PageViewTrackingFake()
        simcoe.providers = [pageViewTracker]
        let expectation = 1

        simcoe.trackPageView("page view test", withAdditionalProperties: nil)

        XCTAssertEqual(pageViewTracker.pageViewTrackCount, expectation,
            "Expected result = Called \(expectation) times; got \(pageViewTracker.pageViewTrackCount)")
    }

    func test_that_it_logs_events_to_providers() {
        let eventTracker = EventTrackingFake()
        simcoe.providers = [eventTracker]
        let expectation = 1

        simcoe.trackEvent("test", withAdditionalProperties: nil)

        XCTAssertEqual(eventTracker.trackEventCallCount, expectation,
            "Expected result = Called \(expectation) times; got \(eventTracker.trackEventCallCount)")
    }

    func test_that_it_logs_lifetime_events_to_providers() {
        let lifetimeValueIncreaser = LifetimeValueIncreasingFake()
        simcoe.providers = [lifetimeValueIncreaser]
        let expectation = 1

        simcoe.trackLifetimeIncrease(byAmount: 1, forItem: nil, withAdditionalProperties: nil)

        XCTAssertEqual(expectation, lifetimeValueIncreaser.lifetimeValueCallCount,
            "Expected result = Called \(expectation) times; got \(lifetimeValueIncreaser.lifetimeValueCallCount)")
    }

    func test_that_it_logs_location_to_providers() {
        let locationTracker = LocationTrackingFake()
        simcoe.providers = [locationTracker]
        let expectation = 1
        let location = CLLocation(latitude: 0, longitude: 0)

        simcoe.trackLocation(location, withAdditionalProperties: nil)

        XCTAssertEqual(expectation, locationTracker.trackLocationCallCount,
            "Expected result = Called \(expectation) times; got \(locationTracker.trackLocationCallCount)")
    }
    
    func test_that_it_logs_errors_to_providers() {
        let errorLogger = ErrorLoggingFake()
        simcoe.providers = [errorLogger]
        let expectation = 1
        
        simcoe.logError("test", withAdditionalProperties: nil)
        
        XCTAssertEqual(errorLogger.errorLoggingCallCount, expectation,
                       "Expected result = Called \(expectation) times; got \(errorLogger.errorLoggingCallCount)")
    }
    
    func test_that_it_logs_user_attributes_to_providers() {
        let attributesSetter = UserAttributesFake()
        simcoe.providers = [attributesSetter]
        let expectation = 1
        
        simcoe.setUserAttribute("foo", value: "bar")
        
        XCTAssertEqual(attributesSetter.attributesCallCount, expectation,
                       "Expected result = Called \(expectation) times; got \(attributesSetter.attributesCallCount)")
    }

    func test_that_it_does_not_log_to_other_providers() {
        let pageViewTracker = PageViewTrackingFake()
        let eventTracker = EventTrackingFake()
        let expectation = 0
        simcoe.providers = [pageViewTracker, eventTracker]

        simcoe.trackPageView("page view test", withAdditionalProperties: nil)

        XCTAssertEqual(eventTracker.trackEventCallCount, expectation,
            "Expected result = \(expectation); got \(eventTracker.trackEventCallCount)")

    }

}
