//
//  MPEventKeys.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/19/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The MPEvent keys.
///
/// - eventType: The event type.
/// - category: The category.
/// - duration: The duration.
/// - startTime: The start time.
/// - endTime: The end time.
/// - name: The name.
/// - customFlags: The custom flags.
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
