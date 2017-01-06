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

    case eventType = "SimcoeInternalMPEventType"
    case category = "SimcoeInternalMPCategory"
    case duration = "SimcoeInternalMPDuration"
    case startTime = "SimcoeInternalMPStartTime"
    case endTime = "SimcoeInternalMPEndTime"
    case name = "SimcoeInternalName"
    case customFlags = "SimcoeInternalCustomFlags"

    static let allKeys: [MPEventKeys] = [.eventType, .category, .duration, .startTime, .endTime, .name, .customFlags]
    
}
