//
//  Adobe.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/15/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation
import AdobeMobileSDK

public final class Adobe {

    public let name = "Adobe Omniture"

    public init() {

    }

    public func start() {
        ADBMobile.collectLifecycleData()
    }

}

extension Adobe: PageViewTracking  {

    public func trackPageView(pageView: String, withAdditionalProperties properties: Properties?) {
        ADBMobile.trackState(pageView, data: properties)
    }

}

extension Adobe: EventTracking {

    public func trackEvent(event: String, withAdditionalProperties properties: Properties?) {
        ADBMobile.trackAction(event, data: properties)
    }

}

extension Adobe: LifetimeValueIncreasing {

    public func increaseLifetimeValue(byAmount amount: Double, forItem item: String?, withAdditionalProperties properties: Properties?) {
        var data = properties ?? [String: AnyObject]()
        if let item = item {
            data[item] = ""
        }

        ADBMobile.trackLifetimeValueIncrease(NSDecimalNumber(double: 1), data: data)
    }

}

extension Adobe: LocationTracking {

    public func trackLocation(location: CLLocation, withAdditionalProperties properties: [String: AnyObject]?) {
        ADBMobile.trackLocation(location, data: properties)
    }

}
