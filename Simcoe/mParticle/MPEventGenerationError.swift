//
//  MPEventGenerationError.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/20/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

internal enum MPEventGenerationError: ErrorType {

    case NameMissing
    case TypeMissing
    case EventInitFailed

}

extension MPEventGenerationError: CustomStringConvertible {

    var description: String {
        switch self {
        case .NameMissing:
            return "A name is required in order to generate this event."
        case .TypeMissing:
            return "A MPEventType is required in order to generate this event."
        case .EventInitFailed:
            return "Failed to initialize the MPEvent. Check that you have a valid event name and type and try again. Names must not be an empty string."
        }
    }

}
