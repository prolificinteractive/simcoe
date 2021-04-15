//
//  RemoteOutput.swift
//  Simcoe
//
//  Created by Christopher Jones on 4/7/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import Foundation

/// A remote output source.
internal struct RemoteOutput: Output {

    /// The token.
    let token: String

    fileprivate let baseUrl = URL(string: "")!

    fileprivate var url: URL {
        return URL(string: token, relativeTo: baseUrl)!
    }

    /// The default initializer.
    ///
    /// - Parameter token: The token.
    init(token: String) {
        self.token = token

        Swift.print ("DISABLED : Simcoe now logging remotely to URL: \(url.absoluteString)")
    }

    /// Prints a message.
    ///
    /// - Parameter message: The message.
    func print(_ message: String) {
        //removing
    }

}
