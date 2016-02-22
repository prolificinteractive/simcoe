//
//  Adobe.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/15/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation
import AdobeMobileSDK

public class Adobe {

    public let name = "Adobe Omniture"

    public init() {

    }

    public func start() {
        ADBMobile.collectLifecycleData()
    }

}

extension Adobe: PageViewTracking  {

    public func trackPageView(pageView: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        ADBMobile.trackState(pageView, data: properties)
        return .Success
    }

}

extension Adobe: EventTracking {

    public func trackEvent(event: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        ADBMobile.trackAction(event, data: properties)
        return .Success
    }

}

extension Adobe: LifetimeValueIncreasing {

    public func increaseLifetimeValue(byAmount amount: Double, forItem item: String?, withAdditionalProperties properties: Properties?) -> TrackingResult {
        var data = properties ?? [String: AnyObject]()
        if let item = item {
            data[item] = ""
        }

        ADBMobile.trackLifetimeValueIncrease(NSDecimalNumber(double: 1), data: data)
        return .Success
    }

}

extension Adobe: LocationTracking {

    public func trackLocation(location: CLLocation,
        withAdditionalProperties properties: [String: AnyObject]?) -> TrackingResult {
            ADBMobile.trackLocation(location, data: properties)
            return .Success
    }

}
