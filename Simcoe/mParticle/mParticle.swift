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
        self.key = key
        self.secret = secret
    }

    public func start() {
        MParticle.sharedInstance().startWithKey(key, secret:secret)
    }

}

internal enum MPEventKeys: String {
    case EventType = "eventType"
    case Category = "category"
    case Duration = "duration"
    case StartTime = "startTime"
    case EndTime = "endTime"
    case Name = "name"
    case CustomFlags = "customFlags"

    static let allEvents: [MPEventKeys] = [.EventType, .Category, .Duration, .StartTime, .EndTime, .Name, .CustomFlags]
}

public func eventData(type: MPEventType, name: String? = nil, category: String? = nil, duration: Float? = nil, startTime: NSDate? = nil,
    endTime: NSDate? = nil, customFlags: [String: [String]]? = nil, info: [String: AnyObject]? = nil) -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [MPEventKeys.EventType.rawValue: type.rawValue]

        if let name = name {
            dictionary[MPEventKeys.Name.rawValue] = name
        }

        if let category = category {
            dictionary[MPEventKeys.Category.rawValue] = category
        }

        if let duration = duration {
            dictionary[MPEventKeys.Duration.rawValue] = duration
        }

        if let startTime = startTime {
            dictionary[MPEventKeys.StartTime.rawValue] = startTime
        }

        if let endTime = endTime {
            dictionary[MPEventKeys.EndTime.rawValue] = endTime
        }

        if let customFlags = customFlags{
            dictionary[MPEventKeys.CustomFlags.rawValue] = customFlags
        }

        if let info = info {
            for (key, value) in info {
                dictionary[key] = value
            }
        }

        return dictionary
}

internal func toEvent(usingData data: [String: AnyObject], usingSpecificName name: String? = nil) -> MPEvent? {
    guard let eventValue = data[MPEventKeys.EventType.rawValue] as? UInt,
        type = MPEventType(rawValue: eventValue),
        name = name ?? data[MPEventKeys.Name.rawValue] as? String else {
            return nil
    }

    let event = MPEvent(name: name, type: type)!

    if let category = data[MPEventKeys.Category.rawValue] as? String {
        event.category = category
    }

    if let duration = data[MPEventKeys.Duration.rawValue] as? Float {
        event.duration = duration
    }

    if let startTime = data[MPEventKeys.StartTime.rawValue] as? NSDate {
        event.startTime = startTime
    }

    if let endTime = data[MPEventKeys.EndTime.rawValue] as? NSDate {
        event.endTime = endTime
    }

    if let flags = data[MPEventKeys.CustomFlags.rawValue] as? [String: [String]] {
        for (key, flagValues) in flags {
            event.addCustomFlags(flagValues, withKey: key)
        }
    }

    let allKeyStrings = MPEventKeys.allEvents.map { key in
        return key.rawValue
    }

    let unfoundKeys = data.filter({ (key, value) in return !allKeyStrings.contains(key) })

    if unfoundKeys.count > 0 {
        var userInfo = [String: AnyObject]()

        for (key, value) in unfoundKeys {
            userInfo[key] = value
        }

        event.info = userInfo
    }


    return event
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
