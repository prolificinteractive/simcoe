//
//  OutputFake.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/22/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class OutputFake: Output {

    var printCallCount = 0

    func print(message: String) {
        printCallCount += 1
    }

}
