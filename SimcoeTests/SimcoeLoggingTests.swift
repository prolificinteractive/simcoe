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
        let expectation = 1

        let product = ProductFake()
        let eventProperties: Properties? = EventPropertiesFake.eventProperties

        simcoe.logAddToCart(product, eventProperties: eventProperties, providers: [cartLogger])

        XCTAssertEqual(cartLogger.cartAdditionCount, expectation,
                       "Expected result = Called \(expectation) times; got \(cartLogger.cartAdditionCount)")
    }

    func test_that_it_logs_remove_from_cart_to_providers() {
        let cartLogger = CartLoggingFake()
        let expectation = 1

        let product = ProductFake()
        let eventProperties: Properties? = EventPropertiesFake.eventProperties

        simcoe.logRemoveFromCart(product, eventProperties: eventProperties, providers: [cartLogger])

        XCTAssertEqual(cartLogger.cartRemovalCount, expectation,
                       "Expected result = Called \(expectation) times; got \(cartLogger.cartRemovalCount)")
    }

    // MARK: - CheckoutTracking

    func test_that_it_tracks_checkout_event_to_providers() {
        let checkoutTracker = CheckoutTrackingFake()
        let expectation = 1

        let product = ProductFake()
        let eventProperties: Properties? = EventPropertiesFake.eventProperties

        simcoe.trackCheckoutEvent([product], eventProperties: eventProperties, providers: [checkoutTracker])

        XCTAssertEqual(checkoutTracker.checkoutEventCount, expectation,
                       "Expected result = Called \(expectation) times; got \(checkoutTracker.checkoutEventCount)")
    }

    // MARK: - ErrorLogging

    func test_that_it_logs_errors_to_providers() {
        let errorLogger = ErrorLoggingFake()
        let expectation = 1

        simcoe.log(error: "test", withAdditionalProperties: nil, providers: [errorLogger])

        XCTAssertEqual(errorLogger.errorLoggingCallCount, expectation,
                       "Expected result = Called \(expectation) times; got \(errorLogger.errorLoggingCallCount)")
    }

    // MARK: - EventTracking

    func test_that_it_logs_events_to_providers() {
        let eventTracker = EventTrackingFake()
        let expectation = 1

        simcoe.track(event: "test", withAdditionalProperties: nil, providers: [eventTracker])

        XCTAssertEqual(eventTracker.trackEventCallCount, expectation,
                       "Expected result = Called \(expectation) times; got \(eventTracker.trackEventCallCount)")
    }

    // MARK: - LifetimeValueTracking

    func test_that_it_logs_lifetime_value_to_providers() {
        let lifetimeValueTracker = LifetimeValueTrackingFake()
        let expectation = 1

        simcoe.trackLifetimeValue("test", value: 1, withAdditionalProperties: nil)

        XCTAssertEqual(expectation, lifetimeValueTracker.lifetimeValueCallCount,
                       "Expected result = Called \(expectation) times; got \(lifetimeValueTracker.lifetimeValueCallCount)")
    }

    func test_that_it_logs_multiple_lifetime_values_to_providers() {
        let lifetimeValueTracker = LifetimeValueTrackingFake()
        let expectation = 3

        let attributes = [
            "foo": 1,
            "bar": 2,
            "yes": 3
        ]

        simcoe.trackLifetimeValues(attributes, withAdditionalProperties: nil)

        XCTAssertEqual(lifetimeValueTracker.lifetimeValueCallCount, expectation,
                       "Expected result = Called \(expectation) times; got \(lifetimeValueTracker.lifetimeValueCallCount)")
    }

    // MARK: - LocationTracking

    func test_that_it_logs_location_to_providers() {
        let locationTracker = LocationTrackingFake()
        let expectation = 1
        let location = CLLocation(latitude: 0, longitude: 0)

        simcoe.track(location: location, withAdditionalProperties: nil, providers: [locationTracker])

        XCTAssertEqual(expectation, locationTracker.trackLocationCallCount,
                       "Expected result = Called \(expectation) times; got \(locationTracker.trackLocationCallCount)")
    }

    // MARK: - PageViewTracking

    func test_that_it_logs_page_views_to_providers() {
        let pageViewTracker = PageViewTrackingFake()
        let expectation = 1

        simcoe.track(pageView: "page view test", withAdditionalProperties: nil, providers: [pageViewTracker])

        XCTAssertEqual(pageViewTracker.pageViewTrackCount, expectation,
                       "Expected result = Called \(expectation) times; got \(pageViewTracker.pageViewTrackCount)")
    }

    // MARK: - PurchaseTracking

    func test_that_it_logs_purchase_events_to_providers() {
        let purchaseTracker = PurchaseTrackingFake()
        let expectation = 1

        let product = ProductFake()
        let eventProperties: Properties? = EventPropertiesFake.eventProperties

        simcoe.trackPurchaseEvent([product], eventProperties: eventProperties, providers: [purchaseTracker])

        XCTAssertEqual(purchaseTracker.purchaseEventCount, expectation,
                       "Expected result = Called \(expectation) times; got \(purchaseTracker.purchaseEventCount)")
    }

    // MARK: - SuperPropertyTracking

    func test_that_it_logs_setting_properties_to_providers() {
        let superPropertyTracker = SuperPropertyTrackingFake()
        let expectation = 1

        let eventProperties: Properties = EventPropertiesFake.eventProperties

        simcoe.set(superProperties: eventProperties, providers: [superPropertyTracker])

        XCTAssertEqual(superPropertyTracker.superPropertyEventCount, expectation,
                       "Expected result = Called \(expectation) times; got \(superPropertyTracker.superPropertyEventCount)")
    }

    func test_that_it_logs_unsetting_properties_to_providers() {
        let superPropertyTracker = SuperPropertyTrackingFake()
        let expectation = 1

        simcoe.unset(superProperty: "", providers: [superPropertyTracker])

        XCTAssertEqual(superPropertyTracker.superPropertyEventCount, expectation,
                       "Expected result = Called \(expectation) times; got \(superPropertyTracker.superPropertyEventCount)")
    }

    func test_that_it_logs_unsetting_all_properties_to_providers() {
        let superPropertyTracker = SuperPropertyTrackingFake()
        simcoe.providers = [superPropertyTracker]
        let expectation = 1

        simcoe.clearSuperProperties()

        XCTAssertEqual(superPropertyTracker.superPropertyEventCount, expectation,
                       "Expected result = Called \(expectation) times; got \(superPropertyTracker.superPropertyEventCount)")
    }

    // MARK: - TimedEventTracking

    func test_that_it_logs_start_timed_event_to_providers() {
        let timedEventTracker = TimedEventTrackingFake()
        let expectation = 1

        simcoe.start(timedEvent: "test", withAdditionalProperties: nil, providers: [timedEventTracker])

        XCTAssertEqual(timedEventTracker.trackTimedEventCallCount, expectation,
                       "Expected result = Called \(expectation) times; got \(timedEventTracker.trackTimedEventCallCount)")
    }

    func test_that_it_logs_stop_timed_event_to_providers() {
        let timedEventTracker = TimedEventTrackingFake()
        let expectation = 1

        simcoe.end(timedEvent: "test", withAdditionalProperties: nil, providers: [timedEventTracker])

        XCTAssertEqual(timedEventTracker.trackTimedEventCallCount, expectation,
                       "Expected result = Called \(expectation) times; got \(timedEventTracker.trackTimedEventCallCount)")
    }

    // MARK: - UserAttributeTracking

    func test_that_it_logs_user_attributes_to_providers() {
        let attributesSetter = UserAttributesFake()
        let expectation = 1

        simcoe.setUserAttribute("foo", value: "bar" as String, providers: [attributesSetter])

        XCTAssertEqual(attributesSetter.attributesCallCount, expectation,
                       "Expected result = Called \(expectation) times; got \(attributesSetter.attributesCallCount)")
    }

    func test_that_it_logs_multiple_user_attributes_to_providers() {
        let attributesSetter = UserAttributesFake()
        let expectation = 3

        let attributes = [
            "foo": "bar",
            "bar": "foo",
            "yes": "no"
        ]

        simcoe.setUserAttributes(attributes, providers: [attributesSetter])

        XCTAssertEqual(attributesSetter.attributesCallCount, expectation,
                       "Expected result = Called \(expectation) times; got \(attributesSetter.attributesCallCount)")
    }

    // MARK: - ViewDetailLogging

    func test_that_it_logs_view_detail_event_to_providers() {
        let viewDetailLogger = ViewDetailLoggingFake()
        let expectation = 1

        let product = ProductFake()
        let eventProperties: Properties? = EventPropertiesFake.eventProperties

        simcoe.logViewDetail(product, eventProperties: eventProperties, providers: [viewDetailLogger])

        XCTAssertEqual(viewDetailLogger.viewDetailEventCount, expectation,
                       "Expected result = Called \(expectation) times; got \(viewDetailLogger.viewDetailEventCount)")
    }

    // MARK: - Other

    func test_that_it_does_not_log_to_other_providers() {
        let pageViewTracker = PageViewTrackingFake()
        let eventTracker = EventTrackingFake()
        simcoe.providers = [pageViewTracker, eventTracker]
        let expectation = 0

        simcoe.track(pageView: "page view test", withAdditionalProperties: nil)
        
        XCTAssertEqual(eventTracker.trackEventCallCount, expectation,
                       "Expected result = \(expectation); got \(eventTracker.trackEventCallCount)")
        
    }
    
}
