//
//  MPEventTests.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/19/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import XCTest
import mParticle_iOS_SDK
@testable import Simcoe

class MPEventTests: XCTestCase {

    func test_that_MPEvent_has_type() {
        let type = MPEventType.Media

        let data = eventData(type: type, name: "Event Type")
        let result = toEvent(usingData: data)

        XCTAssertEqual(result.type, type,
            "Expected result = \(type); got \(result.type)")
    }

    func test_that_MPEvent_has_name() {
        let name = "Hello, World"

        let data = eventData(type: .Other, name: name)
        let result = toEvent(usingData: data)

        XCTAssertEqual(result.name, name,
            "Expected result = \(name); got \(result.name)")
    }

    func test_that_MPEvent_has_category() {
        let category = "A Cool Category"

        let data = eventData(type: .Other, name: "Category", category: category)
        let result = toEvent(usingData: data)

        XCTAssertEqual(category, result.category,
            "Expected result = \(category); got \(result.category)")
    }

    func test_that_MPEvent_has_duration() {
        let duration: Float = 40

        let data = eventData(type: .Other, name: "Duration", duration: duration)
        let result = toEvent(usingData: data)

        XCTAssertEqual(duration, result.duration,
            "Expected result = \(duration); got \(result.duration)")
    }

    func test_that_MPEvent_has_startTime() {
        let startTime = NSDate(timeIntervalSinceReferenceDate: 1000)

        let data = eventData(type: .Other, name: "Start Time", startTime: startTime)
        let result = toEvent(usingData: data)

        XCTAssertEqual(startTime.timeIntervalSinceReferenceDate, result.startTime?.timeIntervalSinceReferenceDate,
            "Expected result = \(startTime.timeIntervalSinceReferenceDate); got \(result.startTime?.timeIntervalSinceReferenceDate)")
    }

    func test_that_MPEvent_has_endTime() {
        let endTime = NSDate(timeIntervalSinceReferenceDate: 1424)

        let data = eventData(type: .Other, name: "End Time", endTime: endTime)
        let result = toEvent(usingData: data)

        XCTAssertEqual(endTime.timeIntervalSinceReferenceDate, result.endTime?.timeIntervalSinceReferenceDate,
        "Expected result = \(endTime.timeIntervalSinceReferenceDate); got \(result.endTime?.timeIntervalSinceReferenceDate)")
    }

    func test_that_MPEvent_has_customFlags() {
        let key = "Party Time"
        let values = ["Excellent", "Tubular"]
        let customFlags = [key: values]

        let data = eventData(type: .Other, name: "Custom Flags", customFlags: customFlags)
        let result = toEvent(usingData: data)

        XCTAssertEqual(key, result.customFlags.keys.first!,
            "Expected result = \(key); got \(result.customFlags.keys.first!)")
        XCTAssertEqual(result.customFlags[key]!, values,
            "Expected result = \(values); got \(result.customFlags[key]!)")
    }

    func test_that_MPEvent_has_info() {
        let name = "Hello, mParticle"
        let key = "Stuff"
        let value = 42

        let data = eventData(type: .Other, name: name, info: [key: value])
        let result = toEvent(usingData: data)

        XCTAssertNotNil(result.info,
            "Expected info to not be nil; got nil.")
        let resultValue = result.info?[key] as? Int

        XCTAssertNotNil(resultValue,
            "Expected key value to not be nil; got nil.")
        XCTAssertEqual(resultValue!, value,
            "Expected result = \(value); got \(resultValue!)")
    }

}
