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

// MARK: - LifetimeValueTracking

extension Adobe: LifetimeValueTracking {

    /// Tracks the lifetime value.
    ///
    /// - Parameters:
    ///   - key: The lifetime value's identifier.
    ///   - value: The lifetime value.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    public func trackLifetimeValue(_ key: String, value: Any, withAdditionalProperties properties: Properties?) -> TrackingResult {
        var properties = properties ?? Properties()
        properties[key] = ""

        ADBMobile.trackLifetimeValueIncrease(NSDecimalNumber(value: value as? Double ?? 0), data: properties)

        return .success
    }

    /// Track the lifetime values.
    ///
    /// - Parameter:
    ///   - attributes: The lifetime attribute values.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    public func trackLifetimeValues(_ attributes: Properties, withAdditionalProperties properties: Properties?) -> TrackingResult {
        attributes.forEach { (key, value) in
            _ = trackLifetimeValue(key, value: value, withAdditionalProperties: properties)
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
