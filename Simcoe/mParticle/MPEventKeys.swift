//
//  MPEventKeys.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/19/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

internal enum MPEventKeys: String {

    case EventType = "SimcoeInternalMPEventType"
    case Category = "SimcoeInternalMPCategory"
    case Duration = "SimcoeInternalMPDuration"
    case StartTime = "SimcoeInternalMPStartTime"
    case EndTime = "SimcoeInternalMPEndTime"
    case Name = "SimcoeInternalName"
    case CustomFlags = "SimcoeInternalCustomFlags"

    static let allEvents: [MPEventKeys] = [.EventType, .Category, .Duration, .StartTime, .EndTime, .Name, .CustomFlags]
    
}
