//
//  Output.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/22/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// Defines an object as an output source.
internal protocol Output {

    /// Prints a message to the output source.
    ///
    /// - Parameter message: The message to print.
    func print(_ message: String)

}
