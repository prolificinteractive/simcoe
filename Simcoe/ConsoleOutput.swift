//
//  ConsoleOutput.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/22/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The default console output.
internal final class ConsoleOutput: Output {

    /// Prints a message to the standard output.
    ///
    /// - Parameter message: The message to print.
    func print(_ message: String) {
        Swift.print(message)
    }

}
