//
//  MPEventTests.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/19/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import XCTest
import mParticle_Apple_SDK
@testable import Simcoe

class MPEventTests: XCTestCase {

    func test_that_MPEvent_created_with_name_and_type() {
        let properties: [String: AnyObject] =
            [MPEventKeys.Name.rawValue: "Event", MPEventKeys.EventType.rawValue: MPEventType.Other.rawValue]
        let event: MPEvent?
        let eventError: ErrorType?

        do {
            event = try MPEvent.toEvent(usingData: properties)
            eventError = nil
        } catch {
            event = nil
            eventError = error
        }

        XCTAssertNil(eventError,
            "Expected error to be nil; got \(eventError)")
        XCTAssertNotNil(event,
            "Expected event to not be nil; got nil")
    }

    func test_that_name_error_thrown_when_missing() {
        let properties: [String: AnyObject] = [MPEventKeys.EventType.rawValue: MPEventType.Other.rawValue]
        let expected = MPEventGenerationError.NameMissing
        let event: MPEvent?
        let eventError: ErrorType?

        do {
            event = try MPEvent.toEvent(usingData: properties)
            eventError = nil
        } catch {
            event = nil
            eventError = error
        }

        XCTAssertNil(event,
            "Expected event to fail initialization and return nil; got \(event).")
        XCTAssertEqual(expected, eventError as? MPEventGenerationError,
            "Expected result = \(expected); got \(eventError)")
    }

    func test_that_type_error_thrown_when_missing() {
        let properties: [String: AnyObject] = [MPEventKeys.Name.rawValue: "Test"]
        let expected = MPEventGenerationError.TypeMissing
        let event: MPEvent?
        let eventError: ErrorType?

        do {
            event = try MPEvent.toEvent(usingData: properties)
            eventError = nil
        } catch {
            eventError = error
            event = nil
        }

        XCTAssertNil(event,
            "Expected event to be nil; got \(event)")
        XCTAssertEqual(expected, eventError as? MPEventGenerationError,
            "Expected result = \(expected); got \(eventError)")
    }

    func test_that_init_error_thrown_when_bad_data_input() {
        let properties = MPEvent.eventData(type: .Other, name: "")
        let expected = MPEventGenerationError.EventInitFailed
        let event: MPEvent?
        let eventError: MPEventGenerationError?

        do {
            event = try MPEvent.toEvent(usingData: properties)
            eventError = nil
        } catch {
            event = nil
            eventError = error as? MPEventGenerationError
        }

        XCTAssertNil(event,
            "Expected result = event is nil; got not-nil.")
        XCTAssertEqual(expected, eventError,
            "Expected result = \(expected); got \(eventError)")
    }

    func test_that_MPEvent_has_type() {
        let type = MPEventType.Media

        let data = MPEvent.eventData(type: type, name: "Event Type")
        let result = try! MPEvent.toEvent(usingData: data)

        XCTAssertEqual(result.type, type,
            "Expected result = \(type); got \(result.type)")
    }

    func test_that_MPEvent_has_name() {
        let name = "Hello, World"

        let data = MPEvent.eventData(type: .Other, name: name)
        let result = try! MPEvent.toEvent(usingData: data)

        XCTAssertEqual(result.name, name,
            "Expected result = \(name); got \(result.name)")
    }

    func test_that_MPEvent_has_category() {
        let category = "A Cool Category"

        let data = MPEvent.eventData(type: .Other, name: "Category", category: category)
        let result = try! MPEvent.toEvent(usingData: data)

        XCTAssertEqual(category, result.category,
            "Expected result = \(category); got \(result.category)")
    }

    func test_that_MPEvent_has_duration() {
        let duration: Float = 40

        let data = MPEvent.eventData(type: .Other, name: "Duration", duration: duration)
        let result = try! MPEvent.toEvent(usingData: data)

        XCTAssertEqual(duration, result.duration,
            "Expected result = \(duration); got \(result.duration)")
    }

    func test_that_MPEvent_has_startTime() {
        let startTime = NSDate(timeIntervalSinceReferenceDate: 1000)

        let data = MPEvent.eventData(type: .Other, name: "Start Time", startTime: startTime)
        let result = try! MPEvent.toEvent(usingData: data)

        XCTAssertEqual(startTime.timeIntervalSinceReferenceDate, result.startTime?.timeIntervalSinceReferenceDate,
            "Expected result = \(startTime.timeIntervalSinceReferenceDate); got \(result.startTime?.timeIntervalSinceReferenceDate)")
    }

    func test_that_MPEvent_has_endTime() {
        let endTime = NSDate(timeIntervalSinceReferenceDate: 1424)

        let data = MPEvent.eventData(type: .Other, name: "End Time", endTime: endTime)
        let result = try! MPEvent.toEvent(usingData: data)

        XCTAssertEqual(endTime.timeIntervalSinceReferenceDate, result.endTime?.timeIntervalSinceReferenceDate,
        "Expected result = \(endTime.timeIntervalSinceReferenceDate); got \(result.endTime?.timeIntervalSinceReferenceDate)")
    }

    func test_that_MPEvent_has_customFlags() {
        let key = "Party Time"
        let values = ["Excellent", "Tubular"]
        let customFlags = [key: values]

        let data = MPEvent.eventData(type: .Other, name: "Custom Flags", customFlags: customFlags)
        let result = try! MPEvent.toEvent(usingData: data)

        XCTAssertEqual(key, result.customFlags.keys.first!,
            "Expected result = \(key); got \(result.customFlags.keys.first!)")
        XCTAssertEqual(result.customFlags[key]!, values,
            "Expected result = \(values); got \(result.customFlags[key]!)")
    }

    func test_that_MPEvent_has_info() {
        let name = "Hello, mParticle"
        let key = "Stuff"
        let value = 42

        let data = MPEvent.eventData(type: .Other, name: name, info: [key: value])
        let result = try! MPEvent.toEvent(usingData: data)

        XCTAssertNotNil(result.info,
            "Expected info to not be nil; got nil.")
        let resultValue = result.info?[key] as? Int

        XCTAssertNotNil(resultValue,
            "Expected key value to not be nil; got nil.")
        XCTAssertEqual(resultValue!, value,
            "Expected result = \(value); got \(resultValue!)")
    }

}
