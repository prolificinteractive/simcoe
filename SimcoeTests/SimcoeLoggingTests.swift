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

internal final class SimcoeLoggingTests: XCTestCase {

    var simcoe: Simcoe!

    override func setUp() {
        super.setUp()

        simcoe = Simcoe(tracker: Tracker())
    }

    // MARK: - CartLogging

    func test_that_it_logs_add_to_cart_to_providers() {
        let cartLogger = CartLoggingFake()
        simcoe.providers = [cartLogger]
        let expectation = 1

        let product = ProductFake()
        let eventProperties: Properties? = EventPropertiesFake.eventProperties

        simcoe.logAddToCart(product, eventProperties: eventProperties)

        XCTAssertEqual(cartLogger.cartAdditionCount, expectation,
                       "Expected result = Called \(expectation) times; got \(cartLogger.cartAdditionCount)")
    }

    func test_that_it_logs_remove_from_cart_to_providers() {
        let cartLogger = CartLoggingFake()
        simcoe.providers = [cartLogger]
        let expectation = 1

        let product = ProductFake()
        let eventProperties: Properties? = EventPropertiesFake.eventProperties

        simcoe.logRemoveFromCart(product, eventProperties: eventProperties)

        XCTAssertEqual(cartLogger.cartRemovalCount, expectation,
                       "Expected result = Called \(expectation) times; got \(cartLogger.cartRemovalCount)")
    }

    // MARK: - CheckoutTracking

    func test_that_it_tracks_checkout_event_to_providers() {
        let checkoutTracker = CheckoutTrackingFake()
        simcoe.providers = [checkoutTracker]
        let expectation = 1

        let product = ProductFake()
        let eventProperties: Properties? = EventPropertiesFake.eventProperties

        simcoe.trackCheckoutEvent([product], eventProperties: eventProperties)

        XCTAssertEqual(checkoutTracker.checkoutEventCount, expectation,
                       "Expected result = Called \(expectation) times; got \(checkoutTracker.checkoutEventCount)")
    }

    // MARK: - ErrorLogging

    func test_that_it_logs_errors_to_providers() {
        let errorLogger = ErrorLoggingFake()
        simcoe.providers = [errorLogger]
        let expectation = 1

        simcoe.log(error: "test", withAdditionalProperties: nil)

        XCTAssertEqual(errorLogger.errorLoggingCallCount, expectation,
                       "Expected result = Called \(expectation) times; got \(errorLogger.errorLoggingCallCount)")
    }

    // MARK: - EventTracking

    func test_that_it_logs_events_to_providers() {
        let eventTracker = EventTrackingFake()
        simcoe.providers = [eventTracker]
        let expectation = 1

        simcoe.track(event: "test", withAdditionalProperties: nil)

        XCTAssertEqual(eventTracker.trackEventCallCount, expectation,
                       "Expected result = Called \(expectation) times; got \(eventTracker.trackEventCallCount)")
    }

    // MARK: - LifetimeValueIncreasing

    func test_that_it_logs_lifetime_events_to_providers() {
        let lifetimeValueIncreaser = LifetimeValueIncreasingFake()
        simcoe.providers = [lifetimeValueIncreaser]
        let expectation = 1

        simcoe.trackLifetimeIncrease(byAmount: 1, forItem: nil, withAdditionalProperties: nil)

        XCTAssertEqual(expectation, lifetimeValueIncreaser.lifetimeValueCallCount,
                       "Expected result = Called \(expectation) times; got \(lifetimeValueIncreaser.lifetimeValueCallCount)")
    }

    // MARK: - LocationTracking

    func test_that_it_logs_location_to_providers() {
        let locationTracker = LocationTrackingFake()
        simcoe.providers = [locationTracker]
        let expectation = 1
        let location = CLLocation(latitude: 0, longitude: 0)

        simcoe.track(location: location, withAdditionalProperties: nil)

        XCTAssertEqual(expectation, locationTracker.trackLocationCallCount,
                       "Expected result = Called \(expectation) times; got \(locationTracker.trackLocationCallCount)")
    }

    // MARK: - PageViewTracking

    func test_that_it_logs_page_views_to_providers() {
        let pageViewTracker = PageViewTrackingFake()
        simcoe.providers = [pageViewTracker]
        let expectation = 1

        simcoe.track(pageView: "page view test", withAdditionalProperties: nil)

        XCTAssertEqual(pageViewTracker.pageViewTrackCount, expectation,
                       "Expected result = Called \(expectation) times; got \(pageViewTracker.pageViewTrackCount)")
    }

    // MARK: - UserAttributeTracking

    func test_that_it_logs_user_attributes_to_providers() {
        let attributesSetter = UserAttributesFake()
        simcoe.providers = [attributesSetter]
        let expectation = 1

        simcoe.setUserAttribute("foo", value: "bar" as AnyObject)

        XCTAssertEqual(attributesSetter.attributesCallCount, expectation,
                       "Expected result = Called \(expectation) times; got \(attributesSetter.attributesCallCount)")
    }

    // MARK: - Other

    func test_that_it_does_not_log_to_other_providers() {
        let pageViewTracker = PageViewTrackingFake()
        let eventTracker = EventTrackingFake()
        let expectation = 0
        simcoe.providers = [pageViewTracker, eventTracker]

        simcoe.track(pageView: "page view test", withAdditionalProperties: nil)
        
        XCTAssertEqual(eventTracker.trackEventCallCount, expectation,
                       "Expected result = \(expectation); got \(eventTracker.trackEventCallCount)")
        
    }
    
}
