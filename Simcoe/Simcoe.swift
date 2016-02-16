//
//  Simcoe.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation

/// The root analytics engine.
public final class Simcoe {

    /// The analytics data recorder.
    public let recorder = Recorder()

    private var providers = [AnalyticsTracking]() {
        didSet {
            for provider in providers {
                provider.start()
            }
        }
    }
    
    private static let engine = Simcoe()

    /**
     Retrieves the provider based on its kind from the current list of providers.

     - parameter _: The kind of provider to retrieve.

     - returns: The provider if it is exists; otherwise nil.
     */
    public static func provider<T: AnalyticsTracking>(ofKind _: T) -> T? {
        return engine.providers.filter({ provider in return provider is T }).first as? T
    }

    /**
     Begins running using the input providers.

     - parameter providers: The providers to use for analytics tracking.
     */
    public static func run(withProviders providers: [AnalyticsTracking]) {
        engine.providers = providers
    }

    /**
     Tracks a page view.

     - parameter pageView: The page view event.
     */
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

    /**
     Tracks an analytics action or event.

     - parameter event:      The event that occurred.
     - parameter properties: The event properties.
     */
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

    /**
     Tracks the lifetime value increase.

     - parameter value:  The value whose lifetime value is to be increased.
     - parameter amount: The amount to increase that lifetime value for.
     */
    public static func trackLifetimeIncrease(forValue value: String, byAmount amount: Float = 1) {
        engine.providers.map({ provider in return provider as? LifetimeValueIncreasing })
            .flatMap({ $0 })
            .forEach { lifeTimeValueIncreaser in
                lifeTimeValueIncreaser.increaseLifetimeValue(forKey: value, amount: amount)
        }
    }

    /**
     Tracks a user's location.

     - parameter location: The user's location.
     */
    public static func trackLocation(location: CLLocation) {
        engine.providers.map({ provider in return provider as? LocationTracking })
            .flatMap({ $0 })
            .forEach { locationTracker in
                locationTracker.trackLocation(location)
        }
    }

}
