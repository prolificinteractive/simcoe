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

    /// The default analytics logging engine.
    public static let engine = Simcoe(tracker: Tracker())

    /// The analytics data tracker.
    public let tracker: Tracker

    var providers = [AnalyticsTracking]() {
        didSet {
            for provider in providers {
                provider.start()
            }
        }
    }

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
    public static func run(with providers: [AnalyticsTracking] = [AnalyticsTracking]()) {
        var analyticsProviders = providers
        if analyticsProviders.isEmpty {
            analyticsProviders.append(EmptyProvider())
        }

        engine.providers = analyticsProviders
    }

    /**
     Tracks a page view.

     - parameter pageView: The page view event.
     */
    public static func trackPageView(pageView: String, withAdditionalProperties properties: Properties? = nil) {
        engine.trackPageView(pageView, withAdditionalProperties: properties)
    }

    /**
     Tracks an analytics action or event.

     - parameter event:      The event that occurred.
     - parameter properties: The event properties.
     */
    public static func trackEvent(event: String, withAdditionalProperties properties: Properties? = nil) {
        engine.trackEvent(event, withAdditionalProperties: properties)
    }

    /**
     Tracks the lifetime value increase.

     - parameter value:  The value whose lifetime value is to be increased.
     - parameter amount: The amount to increase that lifetime value for.
     */
    public static func trackLifetimeIncrease(byAmount amount: Double = 1, forItem item: String? = nil,
        withAdditionalProperties properties: Properties? = nil) {
            engine.trackLifetimeIncrease(byAmount: amount, forItem: item, withAdditionalProperties: properties)
    }

    /**
     Tracks a user's location.

     - parameter location: The user's location.
     */
    public static func trackLocation(location: CLLocation, withAdditionalProperties properties: Properties?) {
        engine.trackLocation(location, withAdditionalProperties: properties)
    }

    init(tracker: Tracker) {
        self.tracker = tracker
    }

    public func write<T>(toProviders providers: [T], description: String, action: T -> TrackingResult) {
        let writeEvents = providers.map { provider -> WriteEvent in
            let result = action(provider)
            return WriteEvent(provider: provider as! AnalyticsTracking, trackingResult: result)
        }

        let event = Event(writeEvents: writeEvents, description: description)
        tracker.track(event: event)
    }

    func trackPageView(pageView: String, withAdditionalProperties properties: Properties? = nil) {
        let providers: [PageViewTracking] = findProviders()

        write(toProviders: providers, description: "Page View: \(pageView)") { (provider: PageViewTracking) in
            return provider.trackPageView(pageView, withAdditionalProperties: properties)
        }
    }

    func trackEvent(event: String, withAdditionalProperties properties: Properties? = nil) {
        let providers: [EventTracking] = findProviders()

        let propertiesString = properties != nil ? "=> \(properties!.description)" : ""
        write(toProviders: providers, description: "Event: \(event) \(propertiesString)") { eventTracker in
            return eventTracker.trackEvent(event, withAdditionalProperties: properties)
        }
    }

    func trackLifetimeIncrease(byAmount amount: Double = 1, forItem item: String? = nil,
        withAdditionalProperties properties: Properties? = nil) {
            let providers: [LifetimeValueIncreasing] = findProviders()

            write(toProviders: providers, description: "Lifetime Value increased by \(amount) for \(item ?? "")") { lifeTimeValueIncreaser in
               return lifeTimeValueIncreaser
                    .increaseLifetimeValue(byAmount: amount, forItem: item, withAdditionalProperties: properties)
            }
    }

     func trackLocation(location: CLLocation, withAdditionalProperties properties: Properties?) {
        let providers: [LocationTracking] = findProviders()

        write(toProviders: providers, description: "User's Location") { locationTracker in
            locationTracker.trackLocation(location, withAdditionalProperties: properties)
        }
    }

    private func findProviders<T>() -> [T] {
        return providers
            .map({ provider in return provider as? T })
            .flatMap({ $0 })
    }

}
