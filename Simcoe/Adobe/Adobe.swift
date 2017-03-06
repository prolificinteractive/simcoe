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
    open let name = "Adobe Omniture"

    /// The default initializer.
    public init() { }

    /// Starts tracking analytics.
    open func start() {
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

    /// Increases the lifetime value of the key by the specified amount.
    ///
    /// - Parameters:
    ///   - amount: The amount to increase that lifetime value for.
    ///   - item: The optional item to extend.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    public func increaseLifetimeValue(byAmount amount: Double, forItem item: String?, withAdditionalProperties properties: Properties?) -> TrackingResult {
        var data = properties ?? Properties()
        if let item = item {
            data[item] = ""
        }

        ADBMobile.trackLifetimeValueIncrease(NSDecimalNumber(value: amount), data: data)
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
