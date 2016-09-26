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

    case CheckoutOptions = "checkoutOptions"
    case CheckoutStep = "checkoutStep"
    case Currency = "currency"
    case NonInteractive = "nonInteractive"
    case PromotionContainer = "promotionContainer"
    case ProductListName = "productListName"
    case ProductListSource = "productListSource"
    case ScreenName = "screenName"
    case TransactionAttributes = "transactionAttributes"

    static let allKeys: [MPCommerceEventKeys] = [.CheckoutOptions,
                                                 .CheckoutStep,
                                                 .Currency,
                                                 .NonInteractive,
                                                 .PromotionContainer,
                                                 .ProductListName,
                                                 .ProductListSource,
                                                 .ScreenName,
                                                 .TransactionAttributes]

}
