//
//  SimcoeRecorder.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/15/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// A recorder for SimcoeEvents
internal final class Recorder {

    /// Whether the recorder should log all new events to the output or not.
    var writesToOutput = true

    private var events = [Event]()

    /**
     Records the event.

     - parameter event: The event to record.
     */
    func record(event event: Event) {
        events.append(event)
        write(event)
    }

    private func write(event: Event) {
        guard writesToOutput else {
            return
        }

        for provider in event.providerNames {
            print("[\(provider)] \(event.description)")
        }
    }

}