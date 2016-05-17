//
//  ErrorLoggingFake.swift
//  Simcoe
//
//  Created by John Lin on 5/17/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class ErrorLoggingFake: ErrorLogging {
    
    let name = "Error Logging [Fake]"
    
    var errorLoggingCallCount = 0
    
    func logError(error: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        errorLoggingCallCount += 1
        return .Success
    }
    
}
