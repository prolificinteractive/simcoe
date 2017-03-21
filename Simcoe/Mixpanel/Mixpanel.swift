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

// MARK: - LifetimeValueTracking

extension MixpanelPlaceholder: LifetimeValueTracking {

    /// Tracks the lifetime value.
    ///
    /// - Parameters:
    ///   - key: The lifetime value's identifier.
    ///   - value: The lifetime value.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    public func trackLifetimeValue(_ key: String, value: Any, withAdditionalProperties properties: Properties?) -> TrackingResult {
        guard let value = value as? Double else {
            return .error(message: "Value must map to a Double")
        }

        Mixpanel.mainInstance().people.increment(property: key, by: value)

        return .success
    }

    /// Track the lifetime values.
    ///
    /// - Parameter:
    ///   - attributes: The lifetime attribute values.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    public func trackLifetimeValues(_ attributes: Properties, withAdditionalProperties properties: Properties?) -> TrackingResult {
        guard let attributes = attributes as? MixpanelProperties else {
            return .error(message: "All values must map to MixpanelType")
        }

        Mixpanel.mainInstance().people.increment(properties: attributes)

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
