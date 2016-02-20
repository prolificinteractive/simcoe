//
//  mParticleAnalyticsHandler.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import mParticle_iOS_SDK

/// Simcoe Analytics handler for the MParticle iOS SDK.
public class mParticle {

    public let name = "mParticle"

    /**
     Initializes and starts the SDK with the input key and secret.

     - parameter key:    The key.
     - parameter secret: The secret.
     */
    public init(key: String, secret: String) {
        MParticle.sharedInstance().startWithKey(key, secret:secret)
    }

}

extension mParticle: PageViewTracking {

    public func trackPageView(pageView: String, withAdditionalProperties properties: Properties?) {
        MParticle.sharedInstance().logScreen(pageView, eventInfo: properties)
    }

}

extension mParticle: EventTracking {

    /**
     Tracks an mParticle event. 
     
     Internally, this generates an MPEvent object based on the properties passed in. The event string
     passed as the first parameter is delineated as the .name of the MPEvent. As a caller, you are
     required to pass in non-nil properties where one of the properties is the MPEventType. Failure
     to do so will cause this function to fail.
     
     It is recommended that you use the `Simcoe.eventData()` function in order to generate the properties
     dictionary properly.

     - parameter event:      The event name to log.
     - parameter properties: The properties of the event.
     */
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

    /**
     Tracks the user's location. 

     Internally, this generates an MPEvent object based on the properties passed in. As a result, it is
     required that the properties dictionary not be nil and contains keys for .name and .eventType. The latitude
     and longitude of the location object passed in will automatically be added to the info dictionary of the MPEvent
     object; it is recommended not to include them manually unless there are other properties required to use them.
     
     It is recommended that you use the `Simcoe.eventData()` function in order to generate the properties
     dictionary properly.

     - parameter location:   The location data being tracked.
     - parameter properties: The properties for the MPEvent.
     */
    public func trackLocation(location: CLLocation, withAdditionalProperties properties: Properties?) {
        var eventProperties = properties ?? [String: AnyObject]() // TODO: Handle Error
        eventProperties["latitude"] = location.coordinate.latitude
        eventProperties["longitude"] = location.coordinate.longitude

        let event = toEvent(usingData: eventProperties)

        MParticle.sharedInstance().logEvent(event)
    }

}

extension mParticle: LifetimeValueIncreasing {

    public func increaseLifetimeValue(byAmount amount: Double, forItem item: String?,
        withAdditionalProperties properties: Properties?) {
            

            MParticle.sharedInstance().logLTVIncrease(amount, eventName: (item ?? ""), eventInfo: properties)
    }

}
