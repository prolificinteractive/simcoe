//
//  Mixpanel.swift
//  Simcoe
//
//  Created by Yoseob Lee on 2/28/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Mixpanel

typealias MixpanelProperties = [String: MixpanelType]

/// The Mixpanel analytics provider.
public class MixpanelPlaceholder {

    /// The name of the tracker.
    public let name = "Mixpanel"

    /// Initializes an API object with the input token.
    ///
    /// - Parameters:
    ///   - token: The token.
    ///   - launchOptions: The launch options.
    ///   - flushInterval: The interval for background flushing.
    ///   - instanceName: The instance name.
    public init(token: String,
                launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil,
                flushInterval: Double = 60,
                instanceName: String = UUID().uuidString) {
        Mixpanel.initialize(token: token,
                            launchOptions: launchOptions,
                            flushInterval: flushInterval,
                            instanceName: instanceName)
    }


    /// Force uploading of queued data to the Mixpanel server.
    public func stop() {
        Mixpanel.mainInstance().flush()
    }

}

// MARK: - EventTracking

extension MixpanelPlaceholder: EventTracking {

    /// Tracks the given event with optional additional properties.
    ///
    /// - Parameters:
    ///   - event: The event to track.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    public func track(event: String, withAdditionalProperties properties: Properties?) -> TrackingResult {
        guard let data = properties as? MixpanelProperties else {
            return .error(message: "All values must map to MixpanelType")
        }

        Mixpanel.mainInstance().track(event: event, properties: data)

        return .success
    }

}

// MARK: - LifetimeValueIncreasing

extension MixpanelPlaceholder: LifetimeValueIncreasing {

    /// Increments the user property.
    ///
    /// - Parameters:
    ///   - property: The user property.
    ///   - value: The amonut to increment the user property by.
    /// - Returns: A tracking result.
    public func increment(property: String?, value: Double,
                          withAdditionalProperties properties: Properties? = nil) -> TrackingResult {
        Mixpanel.mainInstance().people.increment(property: property ?? "", by: value)

        return .success
    }

    /// Increments the user properties.
    /// All values must be number objects.
    ///
    /// - Parameter userProperties: The user properties.
    /// - Returns: A tracking result.
    public func increment(properties: Properties,
                          withAdditionalProperties data: Properties? = nil) -> TrackingResult {
        guard let properties = properties as? MixpanelProperties else {
            return .error(message: "All values must map to MixpanelType")
        }

        Mixpanel.mainInstance().people.increment(properties: properties)

        return .success
    }
    
}

// MARK: - SuperPropertyTracking

extension MixpanelPlaceholder: SuperPropertyTracking {

    /// Sets the super properties.
    ///
    /// - Parameter properties: The super properties.
    /// - Returns: A tracking result.
    public func set(superProperties: Properties) -> TrackingResult {
        guard let properties = superProperties as? MixpanelProperties else {
            return .error(message: "All values must map to MixpanelType")
        }

        Mixpanel.mainInstance().registerSuperProperties(properties)

        return .success
    }

    /// Unsets the super property.
    ///
    /// - Parameter superProperty: The super property.
    /// - Returns: A tracking result.
    public func unset(superProperty: String) -> TrackingResult {
        Mixpanel.mainInstance().unregisterSuperProperty(superProperty)

        return .success
    }

    /// Clears all currently set super properties.
    ///
    /// - Returns: A tracking result.
    public func clearSuperProperties() -> TrackingResult {
        Mixpanel.mainInstance().clearSuperProperties()

        return .success
    }
    
}

// MARK: - UserAttributeTracking

extension MixpanelPlaceholder: UserAttributeTracking {

    /// Sets the User Attribute.
    ///
    /// - Parameters:
    ///   - key: The attribute key to log.
    ///   - value: The attribute value to log.
    /// - Returns: A tracking result.
    public func setUserAttribute(_ key: String, value: Any) -> TrackingResult {
        guard let value = value as? MixpanelType else {
            return .error(message: "Value must map to MixpanelType")
        }

        Mixpanel.mainInstance().people.set(property: key, to: value)

        return .success
    }

    /// Sets the User Attributes.
    ///
    /// - Parameter attributes: The attribute values to log.
    /// - Returns: A tracking result.
    public func setUserAttributes(_ attributes: Properties) -> TrackingResult {
        guard let properties = attributes as? MixpanelProperties else {
            return .error(message: "All values must map to MixpanelType")
        }

        Mixpanel.mainInstance().people.set(properties: properties)

        return .success
    }

}
