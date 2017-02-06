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
    public static func eventData(type: MPEventType, name: String, category: String? = nil,
                               duration: Float? = nil, startTime: Date? = nil,
                               endTime: Date? = nil, customFlags: [String: [String]]? = nil,
                               info: Properties? = nil) -> Properties {
        var properties = Properties()

        properties[MPEventKeys.eventType.rawValue] = type.rawValue as String
        properties[MPEventKeys.name.rawValue] = name as String

        if let category = category {
            properties[MPEventKeys.category.rawValue] = category as String
        }

        if let duration = duration {
            properties[MPEventKeys.duration.rawValue] = duration as Float
        }

        if let startTime = startTime {
            properties[MPEventKeys.startTime.rawValue] = startTime as Date
        }

        if let endTime = endTime {
            properties[MPEventKeys.endTime.rawValue] = endTime as Date
        }

        if let customFlags = customFlags {
            properties[MPEventKeys.customFlags.rawValue] = customFlags as [String: [String]]
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
        guard let name = data[MPEventKeys.name.rawValue] as? String else {
            throw MPEventGenerationError.nameMissing
        }

        guard let eventValue = data[MPEventKeys.eventType.rawValue] as? UInt,
            let type = MPEventType(rawValue: eventValue) else {
                throw MPEventGenerationError.typeMissing
        }

        guard let event = MPEvent(name: name, type: type) else {
            throw MPEventGenerationError.eventInitFailed
        }

        if let category = data[MPEventKeys.category.rawValue] as? String {
            event.category = category
        }

        if let duration = data[MPEventKeys.duration.rawValue] as? Float {
            event.duration = duration
        }

        if let startTime = data[MPEventKeys.startTime.rawValue] as? Date {
            event.startTime = startTime
        }

        if let endTime = data[MPEventKeys.endTime.rawValue] as? Date {
            event.endTime = endTime
        }

        if let flags = data[MPEventKeys.customFlags.rawValue] as? [String: [String]] {
            for (key, flagValues) in flags {
                event.addCustomFlags(flagValues, withKey: key)
            }
        }

        event.info = MPEventKeys.remaining(properties: data)
        
        return event
    }
    
}
