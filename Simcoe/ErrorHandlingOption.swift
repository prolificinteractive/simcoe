//
//  ErrorHandlingOption.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/22/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 The various options for handling errors.

 - Suppress: Suppresses errors; basically any error is ignored.
 - Default:  Default error handling; errors are logged to the output log.
 - Strict:   Strict error handling; any errors encountered will trigger a fatalError().
 */
public enum ErrorHandlingOption {

    case suppress
    case `default`
    case strict

}
