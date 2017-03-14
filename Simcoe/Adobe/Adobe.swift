//
//  Adobe.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/15/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import AdobeMobileSDK
import CoreLocation

/// The adobe analytics provider.
public class Adobe {

    /// The name of the tracker.
    public let name = "Adobe Omniture"

    /// The default initializer.
    public init() { }

    /// Starts tracking analytics.
    public func start() {
        ADBMobile.collectLifecycleData()
    }

}

// MARK: - EventTracking

extension Adobe: EventTracking {

    /// Tracks the given event with optional additional properties.
    ///
    /// - Parameters:
    ///   - event: The event to track.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    public func track(event: String,
                    withAdditionalProperties properties: Properties?) -> TrackingResult {
        ADBMobile.trackAction(event, data: properties)

        return .success
    }

}

// MARK: - LifetimeValueIncreasing

extension Adobe: LifetimeValueIncreasing {

    /// Increments the property.
    ///
    /// - Parameters:
    ///   - property: The property.
    ///   - value: The amount to increment the property by.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    public func increment(property: String?, value: Double, withAdditionalProperties properties: Properties?) -> TrackingResult {
        var data = properties ?? Properties()

        if let property = property {
            data[property] = ""
        }

        ADBMobile.trackLifetimeValueIncrease(NSDecimalNumber(value: value), data: data)

        return .success
    }

    /// Increments the properties.
    ///
    /// - Parameters:
    ///   - properties: The properties.
    ///   - data: The optional additional properties.
    /// - Returns: A tracking result.
    public func increment(properties: Properties, withAdditionalProperties data: Properties?) -> TrackingResult {
        properties.forEach {
            var data = data ?? Properties()
            data [$0.key] = ""
            let value = $0.value as? Double ?? 0

            ADBMobile.trackLifetimeValueIncrease(NSDecimalNumber(value: value), data: data)
        }

        return .success
    }

}

// MARK: - LocationTracking

extension Adobe: LocationTracking {

    /// Tracks location.
    ///
    /// - Parameters:
    ///   - location: The location to track.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    public func track(location: CLLocation,
                    withAdditionalProperties properties: Properties?) -> TrackingResult {
        ADBMobile.trackLocation(location, data: properties)

        return .success
    }

}

// MARK: - PageViewTracking

extension Adobe: PageViewTracking {

    /// Tracks the page view.
    ///
    /// - Parameters:
    ///   - pageView: The page view to track.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    public func track(pageView: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        ADBMobile.trackState(pageView, data: properties)

        return .success
    }

}
