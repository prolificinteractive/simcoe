//
//  TrackingResult.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/22/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 A result of an analytics tracking operation.

 - Success: The operation was successfully logged to the analytics provider.
 - Error:   An error occurred while logging to the analytics provider; the message value indicates a human-readable description of why that error occurred.
 */
public enum TrackingResult {

    case Success
    case Error(message: String)

}
