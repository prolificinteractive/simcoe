//
//  ViewDetailLoggingFake.swift
//  Simcoe
//
//  Created by Yoseob Lee on 2/27/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class ViewDetailLoggingFake: ViewDetailLogging {

    let name = "View Detail Logging [Fake]"

    var viewDetailEventCount = 0

    func logViewDetail<T : SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) -> TrackingResult {
        viewDetailEventCount += 1
        return .success
    }

}
