//
//  SimcoeRecorder.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/15/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// A recorder for SimcoeEvents
public final class Recorder {

    /// The output option for the recorder. Defaults to .Verbose
    public var outputOption: OutputOptions = .Verbose

    var events = [Event]()

    /**
     Records the event.

     - parameter event: The event to record.
     */
    func record(event event: Event) {
        events.append(event)
        write(event)
    }

    private func write(event: Event) {
        guard outputOption != .None else {
            return
        }

        let writeOut = { (provider: String) in
            print("[\(provider)] \(event.description)")
        }

        if outputOption == .Verbose {
            for provider in event.providerNames {
                writeOut(provider)
            }
        } else {
            writeOut("Analytics")
        }
    }

}