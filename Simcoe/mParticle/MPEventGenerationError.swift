//
//  MPEventGenerationError.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/20/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The MPEvent generation error types.
///
/// - nameMissing: The name missing error.
/// - typeMissing: The type missing error.
/// - eventInitFailed: The event init failed error.
internal enum MPEventGenerationError: Error {

    case nameMissing
    case typeMissing
    case eventInitFailed

}

extension MPEventGenerationError: CustomStringConvertible {

    /// The error description.
    var description: String {
        switch self {
        case .nameMissing:
            return "A name is required in order to generate this event."
        case .typeMissing:
            return "A MPEventType is required in order to generate this event."
        case .eventInitFailed:
            return "Failed to initialize the MPEvent. Check that you have a valid event name and type and try again. Names must not be an empty string."
        }
    }

}
