//
//  ConsoleOutput.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/22/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The default console output.
internal final class ConsoleOutput: Output {

    /**
     Prints a message to the standard output.

     - parameter message: The message to print.
     */
    func print(message: String) {
        Swift.print(message)
    }
    
}