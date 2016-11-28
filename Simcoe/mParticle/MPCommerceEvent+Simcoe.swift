//
//  MPCommerceEvent+Simcoe.swift
//  Simcoe
//
//  Created by Michael Campbell on 10/25/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import mParticle_Apple_SDK

extension MPCommerceEvent {

    /// A convenience initializer for MPCommerceEvent.
    ///
    /// - parameter eventType:       The event type.
    /// - parameter products:        The products.
    /// - parameter eventProperties: The event properties.
    ///
    /// - returns: A MPCommerceEvent instance.
    internal convenience init(eventType: MPCommerceEventAction,
                              products: [MPProduct],
                              eventProperties: Properties?) {
        self.init(action: eventType)

        self.addProducts(products)

        guard let eventProperties = eventProperties else {
            return
        }

        if let checkoutOptions = eventProperties[MPCommerceEventKeys.CheckoutOptions.rawValue] as? String {
            self.checkoutOptions = checkoutOptions
        }

        if let checkoutStep = eventProperties[MPCommerceEventKeys.CheckoutStep.rawValue] as? Int {
            self.checkoutStep = checkoutStep
        }

        if let currency = eventProperties[MPCommerceEventKeys.Currency.rawValue] as? String {
            self.currency = currency
        }

        if let nonInteractive = eventProperties[MPCommerceEventKeys.NonInteractive.rawValue] as? Bool {
            self.nonInteractive = nonInteractive
        }

        if let promotionContainer = eventProperties[MPCommerceEventKeys.PromotionContainer.rawValue] as? MPPromotionContainer {
            self.promotionContainer = promotionContainer
        }

        if let productListName = eventProperties[MPCommerceEventKeys.ProductListName.rawValue] as? String {
            self.productListName = productListName
        }

        if let productListSource = eventProperties[MPCommerceEventKeys.ProductListSource.rawValue] as? String {
            self.productListSource = productListSource
        }

        if let screenName = eventProperties[MPCommerceEventKeys.ScreenName.rawValue] as? String {
            self.screenName = screenName
        }

        self.transactionAttributes = MPTransactionAttributes(properties: eventProperties)

        var remainingAttributes = [String: String]()
        let remaining = MPCommerceEventKeys.remainingProperties(eventProperties)

        for (key, value) in remaining {
            if let value = value as? String {
                remainingAttributes[key] = value
            }
        }

        setCustomAttributes(remainingAttributes)
    }
    
}
