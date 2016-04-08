//
//  SimcoeEvent.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/15/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 A Simcoe Event.
 */
internal struct Event {

    /// The write actions that occurred in this event.
    let writeEvents: [WriteEvent]

    /// The description of the event.
    let description: String

    /// The event's timestamp. Defaults to the current date and time.
    let timestamp = NSDate()

}
