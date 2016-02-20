//
//  MPEvent+Simcoe.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import mParticle_iOS_SDK

/**
 Creates a dictionary used to generate an MPEvent object. All of the input parameters map to
 properties on the MPEvent object. Not setting any of the properties will not initialize those respective
 properties of the MPEvent object.
 
 The `info` parameter will generate additional key / value pairs into the root level of the dictionary.
 
 It is safe to additionally add key / values into the root of the dictionary; any key / values passed in that
 are not recognized will be set in the info dictionary of the generated MPEvent object.

 - parameter type:        The event type. Required.
 - parameter name:        The event name. Required.
 - parameter category:    The category of the event. Optional.
 - parameter duration:    The duration of the event. Optional.
 - parameter startTime:   The start time of the event. Optional.
 - parameter endTime:     The end time of the event. Optional.
 - parameter customFlags: The custom flags for the event. Optional.
 - parameter info:        Additional key / value pairs to place into the root level of the dictionary. These will 
                            map to the `info` dictionary of the generated MPEvent object.

 - returns: A dictionary containing the information for generating an MPEvent.
 */
public func eventData(type type: MPEventType, name: String, category: String? = nil,
    duration: Float? = nil, startTime: NSDate? = nil,
    endTime: NSDate? = nil, customFlags: [String: [String]]? = nil,
    info: [String: AnyObject]? = nil) -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [MPEventKeys.EventType.rawValue: type.rawValue]

        dictionary[MPEventKeys.EventType.rawValue] = type.rawValue
        dictionary[MPEventKeys.Name.rawValue] = name

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

internal func toEvent(usingData data: [String: AnyObject]) throws -> MPEvent {
    guard let name = data[MPEventKeys.Name.rawValue] as? String else {
        throw MPEventGenerationError.NameMissing
    }

    guard let eventValue = data[MPEventKeys.EventType.rawValue] as? UInt,
        type = MPEventType(rawValue: eventValue) else {
            throw MPEventGenerationError.TypeMissing
    }

    guard let event = MPEvent(name: name, type: type) else {
        throw MPEventGenerationError.EventInitFailed
    }

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
