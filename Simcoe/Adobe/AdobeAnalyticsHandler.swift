//
//  Adobe.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/15/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation
import AdobeMobileSDK

public final class AdobeAnalyticsHandler {

    public let name = "Adobe Omniture"

    public init() {

    }

    public func start() {
        ADBMobile.collectLifecycleData()
    }

}

extension AdobeAnalyticsHandler: PageViewTracking  {

    public func trackPageView(pageView: String) {
        ADBMobile.trackState(pageView, data: nil)
    }

}

extension AdobeAnalyticsHandler: EventTracking {

    public func trackEvent(event: String, withAdditionalProperties properties: [String : String]?) {
        ADBMobile.trackAction(event, data: properties)
    }

}

extension AdobeAnalyticsHandler: LifetimeValueIncreasing {

    public func increaseLifetimeValue(forKey key: String, amount: Float) {
        ADBMobile.trackLifetimeValueIncrease(NSDecimalNumber(float: 1), data: [key: ""])
    }

}

extension AdobeAnalyticsHandler: LocationTracking {

    public func trackLocation(location: CLLocation) {
        ADBMobile.trackLocation(location, data: nil)
    }

}
