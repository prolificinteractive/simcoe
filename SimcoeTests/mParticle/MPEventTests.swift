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
        var properties = Properties()
        properties[MPEventKeys.name.rawValue] = "Event"
        properties[MPEventKeys.eventType.rawValue] = MPEventType.other.rawValue

        let event: MPEvent?
        let eventError: Error?

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
        var properties = Properties()
        properties[MPEventKeys.eventType.rawValue] = MPEventType.other.rawValue

        let expected = MPEventGenerationError.nameMissing
        let event: MPEvent?
        let eventError: Error?

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
        var properties = Properties()
        properties[MPEventKeys.name.rawValue] = "Test"

        let expected = MPEventGenerationError.typeMissing
        let event: MPEvent?
        let eventError: Error?

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
        let properties = MPEvent.eventData(type: .other, name: "")
        let expected = MPEventGenerationError.eventInitFailed
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
        let type = MPEventType.media

        let data = MPEvent.eventData(type: type, name: "Event Type")
        let result = try! MPEvent.toEvent(usingData: data)

        XCTAssertEqual(result.type, type,
            "Expected result = \(type); got \(result.type)")
    }

    func test_that_MPEvent_has_name() {
        let name = "Hello, World"

        let data = MPEvent.eventData(type: .other, name: name)
        let result = try! MPEvent.toEvent(usingData: data)

        XCTAssertEqual(result.name, name,
            "Expected result = \(name); got \(result.name)")
    }

    func test_that_MPEvent_has_category() {
        let category = "A Cool Category"

        let data = MPEvent.eventData(type: .other, name: "Category", category: category)
        let result = try! MPEvent.toEvent(usingData: data)

        XCTAssertEqual(category, result.category,
            "Expected result = \(category); got \(result.category)")
    }

    func test_that_MPEvent_has_duration() {
        let duration: Float = 40

        let data = MPEvent.eventData(type: .other, name: "Duration", duration: duration)
        let result = try! MPEvent.toEvent(usingData: data)

        XCTAssertEqual(duration, result.duration as! Float,
            "Expected result = \(duration); got \(result.duration)")
    }

    func test_that_MPEvent_has_customFlags() {
        let key = "Party Time"
        let values = ["Excellent", "Tubular"]
        let customFlags = [key: values]

        let data = MPEvent.eventData(type: .other, name: "Custom Flags", customFlags: customFlags)
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

        let data = MPEvent.eventData(type: .other, name: name, info: [key: value as Int])
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
