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

    func test_that_MPEvent_input_name_supercedes_dictionary_value() {
        let inputName = "mParticle Name"
        let dictionaryName = "mParticle Input Value Name"

        let data = eventData(.Other, name: dictionaryName)
        let result = toEvent(usingData: data, usingSpecificName: inputName)

        let nonNil = checkNil(result)
        XCTAssertEqual(inputName, nonNil.name,
            "Expected result = \(inputName); got \(nonNil.name)")
    }

    func test_that_MPEvent_has_name() {
        let name = "Hello, World"

        let data = eventData(.Other, name: name)
        let result = toEvent(usingData: data)

        let nonNil = checkNil(result)
        XCTAssertEqual(nonNil.name, name,
            "Expected result = \(name); got \(nonNil.name)")
    }

    func test_that_MPEvent_has_category() {
        let category = "A Cool Category"

        let data = eventData(.Other, category: category)
        let result = toEvent(usingData: data, usingSpecificName: "Category")

        let nonNil = checkNil(result)
        XCTAssertEqual(category, nonNil.category,
            "Expected result = \(category); got \(nonNil.category)")
    }

    func test_that_MPEvent_has_duration() {
        let duration: Float = 40

        let data = eventData(.Other, duration: duration)
        let result = toEvent(usingData: data, usingSpecificName: "Duration")

        let nonNil = checkNil(result)
        XCTAssertEqual(duration, nonNil.duration,
            "Expected result = \(duration); got \(nonNil.duration)")
    }

    func test_that_MPEvent_has_startTime() {
        let startTime = NSDate(timeIntervalSinceReferenceDate: 1000)

        let data = eventData(.Other, startTime: startTime)
        let result = toEvent(usingData: data, usingSpecificName: "Start Time")

        let nonNil = checkNil(result)
        XCTAssertEqual(startTime.timeIntervalSinceReferenceDate, nonNil.startTime?.timeIntervalSinceReferenceDate,
            "Expected result = \(startTime.timeIntervalSinceReferenceDate); got \(nonNil.startTime?.timeIntervalSinceReferenceDate)")
    }

    func test_that_MPEvent_has_endTime() {
        let endTime = NSDate(timeIntervalSinceReferenceDate: 1424)

        let data = eventData(.Other, endTime: endTime)
        let result = toEvent(usingData: data, usingSpecificName: "End Time")

        let nonNil = checkNil(result)
        XCTAssertEqual(endTime.timeIntervalSinceReferenceDate, nonNil.endTime?.timeIntervalSinceReferenceDate,
        "Expected result = \(endTime.timeIntervalSinceReferenceDate); got \(nonNil.endTime?.timeIntervalSinceReferenceDate)")
    }

    func test_that_MPEvent_has_customFlags() {
        let key = "Party Time"
        let values = ["Excellent", "Tubular"]
        let customFlags = [key: values]

        let data = eventData(.Other, customFlags: customFlags)
        let result = toEvent(usingData: data, usingSpecificName: "Custom Flags")

        let nonNil = checkNil(result)
        XCTAssertEqual(key, nonNil.customFlags.keys.first!,
            "Expected result = \(key); got \(nonNil.customFlags.keys.first!)")
        XCTAssertEqual(nonNil.customFlags[key]!, values,
            "Expected result = \(values); got \(nonNil.customFlags[key]!)")
    }

    func test_that_MPEvent_has_info() {
        let name = "Hello, mParticle"
        let key = "Stuff"
        let value = 42

        let data = eventData(.Other, name: name, info: [key: value])
        let result = toEvent(usingData: data)

        let nonNil = checkNil(result)

        XCTAssertNotNil(nonNil.info,
            "Expected info to not be nil; got nil.")
        let resultValue = nonNil.info?[key] as? Int

        XCTAssertNotNil(resultValue,
            "Expected key value to not be nil; got nil.")
        XCTAssertEqual(resultValue!, value,
            "Expected result = \(value); got \(resultValue!)")
    }

    private func checkNil(result: MPEvent?) -> MPEvent {
        XCTAssertNotNil(result, "Expected result: result not nil.")
        return result!
    }
}
