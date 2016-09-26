//
//  MPEventKeys.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/19/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The MPEvent keys.
///
/// - EventType:    The event type.
/// - Category:     The category.
/// - Duration:     The duration.
/// - StartTime:    The start time.
/// - EndTime:      The end time.
/// - Name:         The name.
/// - CustomFlags:  The custom flags.
public enum MPEventKeys: String, EnumerationListable {

    case EventType = "SimcoeInternalMPEventType"
    case Category = "SimcoeInternalMPCategory"
    case Duration = "SimcoeInternalMPDuration"
    case StartTime = "SimcoeInternalMPStartTime"
    case EndTime = "SimcoeInternalMPEndTime"
    case Name = "SimcoeInternalName"
    case CustomFlags = "SimcoeInternalCustomFlags"

    static let allKeys: [MPEventKeys] = [.EventType, .Category, .Duration, .StartTime, .EndTime, .Name, .CustomFlags]
    
}
