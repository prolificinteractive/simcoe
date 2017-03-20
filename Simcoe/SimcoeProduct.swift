//
//  SimcoeProduct.swift
//  Simcoe
//
//  Created by Michael Campbell on 10/25/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The product.
public struct SimcoeProduct {

    /// The product name.
    public let productName: String

    /// The product Id.
    public let productId: String

    /// The quantity.
    public let quantity: Int

    /// The price.
    public let price: Double?

    /// The properties.
    public let properties: Properties?

    /// The default initializer.
    ///
    /// - Parameters:
    ///   - productName: The product name.
    ///   - productId: The product Id.
    ///   - quantity: The quantity.
    ///   - price: The price.
    ///   - properties: The properties.
    public init(productName: String,
                productId: String,
                quantity: Int,
                price: Double?,
                properties: Properties?) {
        self.productName = productName
        self.productId = productId
        self.quantity = quantity
        self.price = price
        self.properties = properties
    }
}
