//
//  Simcoe.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation

public final class Simcoe {

    let recorder = Recorder()

    private var providers = [AnalyticsTracking]() {
        didSet {
            for provider in providers {
                provider.start()
            }
        }
    }
    
    private static let engine = Simcoe()

    public static func shouldPostEventsToOutput(postEventsToOutput: Bool) {
        engine.recorder.writesToOutput = postEventsToOutput
    }

    public static func provider<T: AnalyticsTracking>(ofKind _: T) -> T? {
        return engine.providers.filter({ provider in return provider is T }).first as? T
    }

    public static func runWithProviders(providers: [AnalyticsTracking]) {
        engine.providers = providers
    }

    public static func trackPageView(pageView: String) {
        let providers = engine.providers
            .map({ provider in return provider as? PageViewTracking })
            .flatMap({ $0 })

        providers.forEach { pageTrackingProvider in
            pageTrackingProvider.trackPageView(pageView)
        }

        let event = Event(providerNames: providers.map({ provider in return provider.name }),
            description: "Page View: \(pageView)")
        engine.recorder.record(event: event)
    }

    public static func trackEvent(event: String, withAdditionalProperties properties: [String: String]? = nil) {
        let providers = engine.providers.map({ provider in return provider as? EventTracking })
            .flatMap({ $0 })

        providers.forEach { eventTracker in
            eventTracker.trackEvent(event, withAdditionalProperties: properties)
        }

        let propertiesString = properties != nil ? "=> \(properties!.description)" : ""
        let event = Event(providerNames: providers.map({ provider in return provider.name }),
            description: "Event: \(event) \(propertiesString)")
        engine.recorder.record(event: event)
    }

    public static func trackLifetimeIncrease(forValue value: String, byAmount amount: Int = 1) {
        engine.providers.map({ provider in return provider as? LifetimeValueIncreasing })
            .flatMap({ $0 })
            .forEach { lifeTimeValueIncreaser in
                lifeTimeValueIncreaser.increaseLifetimeValue(forKey: value, amount: amount)
        }
    }

    public static func trackLocation(location: CLLocation) {
        engine.providers.map({ provider in return provider as? LocationTracking })
            .flatMap({ $0 })
            .forEach { locationTracker in
                locationTracker.trackLocation(location)
        }
    }

}
