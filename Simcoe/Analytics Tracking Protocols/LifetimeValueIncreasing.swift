//
//  LifetimeValueIncreasing.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// Defines methods for increasing a lifetime value of an analytics key.
public protocol LifetimeValueIncreasing: AnalyticsTracking {

    /// Increases the lifetime value of the key by the specified amount.
    ///
    /// - Parameters:
    ///   - amount: The amount to increase that lifetime value for.
    ///   - item: The optional item to extend.
    ///   - properties: The optional additional properties.
    /// - Returns: A tracking result.
    func increaseLifetimeValue(byAmount amount: Double,
                                        forItem item: String?,
                                                withAdditionalProperties properties: Properties?) -> TrackingResult

}
