//
//  SimcoeAnalyticsEngine.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe
import CoreLocation

internal class SimcoeAnalyticsEngine: AnalyticsEngine {
    
    func run(with providers: [AnalyticsTracking]) {
        Simcoe.run(with: providers)
    }
    
    func track(event: String, withAdditionalProperties properties: Properties?) {
        Simcoe.track(event: event, withAdditionalProperties: properties)
    }
    
    func trackLifetimeIncrease(byAmount amount: Double,
                               forItem item: String?,
                               withAdditionalProperties properties: Properties?) {
        
        Simcoe.trackLifetimeIncrease(byAmount: amount, forItem: item, withAdditionalProperties: properties)
    }
    
    func track(location: CLLocation, withAdditionalProperties properties: Properties?) {
        Simcoe.track(location: location, withAdditionalProperties: properties)
    }
    
    func track(pageView: String, withAdditionalProperties properties: Properties?) {
        Simcoe.track(pageView: pageView, withAdditionalProperties: properties)
    }
    
    func logAddToCart<T : SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) {
        Simcoe.logAddToCart(product, eventProperties: eventProperties)
    }
    
    func logRemoveFromCart<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) {
        Simcoe.logRemoveFromCart(product, eventProperties: eventProperties)
    }
    
    func trackCheckoutEvent<T: SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?) {
        Simcoe.trackCheckoutEvent(products, eventProperties: eventProperties)
    }
    
    func log(error: String, withAdditionalProperties properties: Properties?) {
        Simcoe.log(error: error, withAdditionalProperties: properties)
    }
    
    func trackPurchaseEvent<T: SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?) {
        Simcoe.trackPurchaseEvent(products, eventProperties: eventProperties)
    }
    
    func setUserAttribute(_ key: String, value: AnyObject) {
        Simcoe.setUserAttribute(key, value: value)
    }
    
    func logViewDetail<T: SimcoeProductConvertible>(_ product: T, eventProperties: Properties?) {
        Simcoe.logViewDetail(product, eventProperties: eventProperties)
    }
}
