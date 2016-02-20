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

    public init(key: String, secret: String) {
        MParticle.sharedInstance().startWithKey(key, secret:secret)
    }

}

extension mParticle: PageViewTracking {

    public func trackPageView(pageView: String, withAdditionalProperties properties: Properties?) {
        let defaultEvents = properties ?? [String: AnyObject]()
        let data = eventData(type: .Navigation, name: pageView, info: defaultEvents)
        let event = toEvent(usingData: data)

        MParticle.sharedInstance().logScreenEvent(event)
    }

}

extension mParticle: EventTracking {

    public func trackEvent(event: String, withAdditionalProperties properties: Properties?) {
        guard let properties = properties else {
            return // TODO: handle errors
        }

        guard let rawValue  = properties[MPEventKeys.EventType.rawValue] as? UInt,
         eventType = MPEventType(rawValue: rawValue) else {
            return // TODO: handle errors
        }

        let eventProperties = eventData(type: eventType, name: event)
        let event = toEvent(usingData: eventProperties)

        MParticle.sharedInstance().logEvent(event)
    }

}

extension mParticle: LocationTracking {

    public func trackLocation(location: CLLocation, withAdditionalProperties properties: Properties?) {
        var eventProperties = properties ?? [String: AnyObject]()
        eventProperties["latitude"] = location.coordinate.latitude
        eventProperties["longitude"] = location.coordinate.longitude

        let rawEvent = eventData(type: .Location, name: "", info: eventProperties)
        let event = toEvent(usingData: rawEvent)

        MParticle.sharedInstance().logEvent(event)
    }

}

extension mParticle: LifetimeValueIncreasing {

    public func increaseLifetimeValue(byAmount amount: Double, forItem item: String?,
        withAdditionalProperties properties: Properties?) {
        MParticle.sharedInstance().logLTVIncrease(amount, eventName: (item ?? ""), eventInfo: properties)
    }

}
