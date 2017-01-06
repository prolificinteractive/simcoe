//
//  EnumerationListable.swift
//  Simcoe
//
//  Created by Michael Campbell on 10/26/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The enumeration listable protocol.
protocol EnumerationListable {

    /// Defines all keys in an enumeration.
    static var allKeys: [Self] { get }
}

extension EnumerationListable where Self: RawRepresentable {

    /// The unfound keys in the provided Properties.
    ///
    /// - parameter properties: The properties.
    ///
    /// - returns: The unfound keys.
    fileprivate static func unfoundKeys(_ properties: Properties) -> [String] {
        let allKeyRawValues: [String] = Self.allKeys.flatMap { $0.rawValue as? String }
        let allKeyRawValuesSet = Set(allKeyRawValues)
        let allPropertiesKeysSet = Set(properties.keys)

        let results: Set<String> = allPropertiesKeysSet.subtracting(allKeyRawValuesSet)

        return results.map { $0 }
    }

    /// The remaining properties.
    ///
    /// - parameter properties: The properties.
    ///
    /// - returns: The remaining properties.
    static func remaining(properties: Properties) -> Properties {
        let unfoundKeys = Self.unfoundKeys(properties)
        var additionalProperties = Properties()

        if unfoundKeys.count > 0 {
            for key in unfoundKeys {
                additionalProperties[key] = properties[key]
            }
        }

        return additionalProperties
    }
    
}
