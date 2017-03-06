//
//  MPCommerceEventKeys.swift
//  Simcoe
//
//  Created by Michael Campbell on 9/26/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The MPCommerceEvent keys available to use with eventProperties.
///
/// - checkoutOptions: The checkout options.
/// - checkoutStep: The checkout step.
/// - currency: The currency.
/// - nonInteractive: The non interactive flag.
/// - promotionContainer: The promotion container.
/// - productListName: The product list name.
/// - productListSource: The product list source.
/// - screenName: The screen name.
/// - transactionAttributes: The transactions attributes.
public enum MPCommerceEventKeys: String, EnumerationListable {

    case checkoutOptions = "checkoutOptions"
    case checkoutStep = "checkoutStep"
    case currency = "currency"
    case nonInteractive = "nonInteractive"
    case promotionContainer = "promotionContainer"
    case productListName = "productListName"
    case productListSource = "productListSource"
    case screenName = "screenName"
    case transactionAttributes = "transactionAttributes"

    static let allKeys: [MPCommerceEventKeys] = [.checkoutOptions,
                                                 .checkoutStep,
                                                 .currency,
                                                 .nonInteractive,
                                                 .promotionContainer,
                                                 .productListName,
                                                 .productListSource,
                                                 .screenName,
                                                 .transactionAttributes]

}
