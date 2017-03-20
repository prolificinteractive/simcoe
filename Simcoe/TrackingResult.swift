//
//  TrackingResult.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/22/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// A result of an analytics tracking operation.
///
/// - success: The operation was successfully logged to the analytics provider.
/// - error: An error occurred while logging to the analytics provider; the message value indicates a human-readable description of why that error occurred.
public enum TrackingResult {

    case success
    case error(message: String)

}
