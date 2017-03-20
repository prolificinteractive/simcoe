//
//  MPTransactionAttributesKeys.swift
//  Simcoe
//
//  Created by Michael Campbell on 11/2/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The MPTransactionAttributes keys available.
///
/// - affiliation: The affiliation.
/// - couponCode: The coupon code.
/// - revenue: The revenue amount.
/// - shipping: The shipping amount.
/// - tax: The tax amount.
/// - transactionId: The transaction Id.
public enum MPTransactionAttributesKeys: String, EnumerationListable {

    case affiliation = "affiliation"
    case couponCode = "couponCode"
    case revenue = "revenue"
    case shipping = "shipping"
    case tax = "tax"
    case transactionId = "transactionId"

    static let allKeys: [MPTransactionAttributesKeys] = [.affiliation, .couponCode, .revenue, .shipping, .tax, .transactionId]

}
