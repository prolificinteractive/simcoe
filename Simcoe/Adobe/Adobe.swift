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
    public func trackEvent(event: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        ADBMobile.trackAction(event, data: properties)
        return .Success
    }
    
}

// MARK: - LifetimeValueIncreasing

extension Adobe: LifetimeValueIncreasing {

    /**
     Increases the lifetime value of the key by the specified amount.

     - parameter amount:     The amount to increase that lifetime value for.
     - parameter item:       The optional item to extend.
     - parameter properties: The optional additional properties.

     - returns: A tracking result.
     */
    public func increaseLifetimeValue(byAmount amount: Double, forItem item: String?, withAdditionalProperties properties: Properties?) -> TrackingResult {
        var data = properties ?? [String: AnyObject]()
        if let item = item {
            data[item] = ""
        }

        ADBMobile.trackLifetimeValueIncrease(NSDecimalNumber(double: 1), data: data)
        return .Success
    }

}

// MARK: - LocationTracking

extension Adobe: LocationTracking {

    /**
     Tracks location.

     - parameter location:   The location to track.
     - parameter properties: The optional additional properties.

     - returns: A tracking result.
     */
    public func trackLocation(location: CLLocation,
                              withAdditionalProperties properties: [String: AnyObject]?) -> TrackingResult {
        ADBMobile.trackLocation(location, data: properties)
        return .Success
    }
    
}

// MARK: - PageViewTracking

extension Adobe: PageViewTracking {

    /**
     Tracks the page view.

     - parameter pageView: The page view to track.

     - returns: A tracking result.
     */
    public func trackPageView(pageView: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        ADBMobile.trackState(pageView, data: properties)
        return .Success
    }

}
