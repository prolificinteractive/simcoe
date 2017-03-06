//
//  MPTransactionAttributes+Simcoe.swift
//  Simcoe
//
//  Created by Michael Campbell on 11/2/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import mParticle_Apple_SDK

extension MPTransactionAttributes {

    /// A convenience initializer for MPTransactionAttributes.
    ///
    /// - Parameter properties: The properties.
    internal convenience init(properties: Properties) {
        self.init()

        if let affiliation = properties[MPTransactionAttributesKeys.affiliation.rawValue] as? String {
            self.affiliation = affiliation
        }

        if let couponCode = properties[MPTransactionAttributesKeys.couponCode.rawValue] as? String {
            self.couponCode = couponCode
        }

        if let revenue = properties[MPTransactionAttributesKeys.revenue.rawValue] as? Double {
            self.revenue = NSNumber(value: revenue)
        }

        if let shipping = properties[MPTransactionAttributesKeys.shipping.rawValue] as? Double {
            self.shipping = NSNumber(value: shipping)
        }

        if let tax = properties[MPTransactionAttributesKeys.tax.rawValue] as? Double {
            self.tax = NSNumber(value: tax)
        }

        if let transactionId = properties[MPTransactionAttributesKeys.transactionId.rawValue] as? String {
            self.transactionId = transactionId
        }
    }
}
