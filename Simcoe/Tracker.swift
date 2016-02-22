//
//  SimcoeRecorder.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/15/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// A recorder for SimcoeEvents
public final class Tracker {

    /// The output option for the recorder. Defaults to .Verbose
    public var outputOption: OutputOptions = .Verbose

    public var errorOption: ErrorHandlingOption = .Default

    var events = [Event]()
    private let outputSource: Output
    
    /**
     Initializes a new instance using the specified source as its output. By default, this is the
     standard output console.

     - parameter outputSource: The source to use for general output.
     */
    init(outputSource: Output = ConsoleOutput()) {
        self.outputSource = outputSource
    }

    /**
     Records the event.

     - parameter event: The event to record.
     */
    func track(event event: Event) {
        events.append(event)
        parseEvent(event)
    }

    private func parseEvent(event: Event) {
        let successfulProviders = event.writeEvents.map { writeEvent -> AnalyticsTracking? in
            switch writeEvent.trackingResult {
            case .Success:
                return writeEvent.provider
            case .Error(let message):
                handleError(usingMessage: message, inProvider: writeEvent.provider)
                return nil
            }
        }

        write(event.description, forProviders: successfulProviders.flatMap { $0 })
    }

    private func handleError(usingMessage message: String, inProvider provider: AnalyticsTracking) {
        switch errorOption {
        case .Default:
            writeOut(withName: "** ANALYTICS ERROR **", message: message)
            break
        case .Strict:
            fatalError(message)
        case .Suppress:
            break
        }
    }

    private func write(description: String, forProviders providers: [AnalyticsTracking]) {
        guard outputOption != .None else {
            return
        }

        if outputOption == .Verbose {
            for provider in providers {
                writeOut(withName: provider.name, message: description)
            }
        } else {
            writeOut(withName: "Analytics", message: description)
        }
    }

    private func writeOut(withName name: String, message: String) {
        outputSource.print("[\(name)] \(message)")
    }
}