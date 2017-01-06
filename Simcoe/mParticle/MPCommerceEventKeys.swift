//
//  MPCommerceEventKeys.swift
//  Simcoe
//
//  Created by Michael Campbell on 9/26/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The MPCommerceEvent keys available to use with eventProperties.
///
/// - CheckoutOptions:       The checkout options.
/// - CheckoutStep:          The checkout step.
/// - Currency:              The currency.
/// - NonInteractive:        The non interactive flag.
/// - PromotionContainer:    The promotion container.
/// - ProductListName:       The product list name.
/// - ProductListSource:     The product list source.
/// - ScreenName:            The screen name.
/// - TransactionAttributes: The transactions attributes.
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
