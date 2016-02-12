//
//  AnalyticsProvider.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation

public protocol AnalyticsTracking {

    var name: String { get }

    func start()

}

public protocol PageViewTracking: AnalyticsTracking {

    func trackPageView(pageView: String)

}

public protocol EventTracking: AnalyticsTracking {

    func trackEvent(event: String, withAdditionalProperties properties: [String: String]?)

}

public protocol LifetimeValueIncreasing: AnalyticsTracking {

    func increaseLifetimeValue(forKey key: String, amount: Int)

}

public protocol LocationTracking: AnalyticsTracking {

    func trackLocation(location: CLLocation)

}
