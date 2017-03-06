//
//  TrackingResult.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The various options for how to output records to the standard output.
///
/// - none: No output; disables records displaying in the output.
/// - simple: Only outputs one item per event, no matter how many providers were recorded.
/// - verbose: Outputs one line for each provider per event, specifying which provider was recorded.
///   This is the best option if you are using many providers and want to verify data is being output
///   to each one.
public enum OutputOptions {

    case none
    case simple
    case verbose

}
