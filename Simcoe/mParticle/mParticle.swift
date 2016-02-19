//
//  mParticleAnalyticsHandler.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import mParticle_iOS_SDK

public class mParticle {

    public let name = "mParticle"

    private let key: String
    private let secret: String

    public init(key: String, secret: String) {
        MParticle.sharedInstance().startWithKey(key, secret:secret)
    }

}

extension mParticle: PageViewTracking {

    public func trackPageView(pageView: String, withAdditionalProperties properties: Properties?) {
        let defaultEvents = properties ?? [String: AnyObject]()
        let data = eventData(.Navigation, info: defaultEvents)
        let event = toEvent(usingData: data, usingSpecificName: pageView)!

        MParticle.sharedInstance().logScreenEvent(event)
    }

}

extension mParticle: LocationTracking {

    public func trackLocation(location: CLLocation, withAdditionalProperties properties: Properties?) {
        var eventProperties = properties ?? [String: AnyObject]()
        eventProperties["latitude"] = location.coordinate.latitude
        eventProperties["longitude"] = location.coordinate.longitude

        let rawEvent = eventData(.Location, info: eventProperties)
        let event = toEvent(usingData: rawEvent)!

        MParticle.sharedInstance().logEvent(event)
    }

}

extension mParticle: LifetimeValueIncreasing {

    public func increaseLifetimeValue(byAmount amount: Double, forItem item: String?, withAdditionalProperties properties: Properties?) {
        MParticle.sharedInstance().logLTVIncrease(amount, eventName: (item ?? ""), eventInfo: properties)
    }

}
