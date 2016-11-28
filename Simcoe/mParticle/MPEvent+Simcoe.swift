//
//  MPEvent+Simcoe.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import mParticle_Apple_SDK

extension MPEvent {

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
    public static func eventData(type type: MPEventType, name: String, category: String? = nil,
                               duration: Float? = nil, startTime: NSDate? = nil,
                               endTime: NSDate? = nil, customFlags: [String: [String]]? = nil,
                               info: Properties? = nil) -> Properties {
        var properties: Properties = [MPEventKeys.EventType.rawValue: type.rawValue]

        properties[MPEventKeys.EventType.rawValue] = type.rawValue
        properties[MPEventKeys.Name.rawValue] = name

        if let category = category {
            properties[MPEventKeys.Category.rawValue] = category
        }

        if let duration = duration {
            properties[MPEventKeys.Duration.rawValue] = duration
        }

        if let startTime = startTime {
            properties[MPEventKeys.StartTime.rawValue] = startTime
        }

        if let endTime = endTime {
            properties[MPEventKeys.EndTime.rawValue] = endTime
        }

        if let customFlags = customFlags {
            properties[MPEventKeys.CustomFlags.rawValue] = customFlags
        }

        if let info = info {
            for (key, value) in info {
                properties[key] = value
            }
        }

        return properties
    }


    /// Generates a MPEvent object based on the passed in Properties.
    ///
    /// - parameter data: The properties.
    ///
    /// - throws: MPEventGenerationError
    ///
    /// - returns: A MPEvent.
    internal static func toEvent(usingData data: Properties) throws -> MPEvent {
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

        event.info = MPEventKeys.remainingProperties(data)
        
        return event
    }
    
}
