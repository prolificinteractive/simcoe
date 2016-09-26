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

        if let affiliation = properties[MPTransactionAttributesKeys.Affiliation.rawValue] as? String {
            self.affiliation = affiliation
        }

        if let couponCode = properties[MPTransactionAttributesKeys.CouponCode.rawValue] as? String {
            self.couponCode = couponCode
        }

        if let revenue = properties[MPTransactionAttributesKeys.Revenue.rawValue] as? Double {
            self.revenue = revenue
        }

        if let shipping = properties[MPTransactionAttributesKeys.Shipping.rawValue] as? Double {
            self.shipping = shipping
        }

        if let tax = properties[MPTransactionAttributesKeys.Tax.rawValue] as? Double {
            self.tax = tax
        }

        if let transactionId = properties[MPTransactionAttributesKeys.TransactionId.rawValue] as? String {
            self.transactionId = transactionId
        }
    }
}
