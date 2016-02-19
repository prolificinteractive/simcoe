//
//  MPEventKeys.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/19/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

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
