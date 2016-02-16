//
//  AnalyticsProvider.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

public protocol AnalyticsTracking {

    var name: String { get }

    func start()

}
