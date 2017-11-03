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

    /// The product brand.
    public let brand: String?

    /// The product category.
    public let category: String?

    /// The coupon associated with the product.
    public let couponCode: String?

    /// The variant of the product.
    public let variant: String?

    /// The product position.
    public let position: UInt?

    /// The properties.
    public let properties: Properties?

    /// The default initializer.
    ///
    /// - Parameters:
    ///   - productName: The product name.
    ///   - productId: The product Id.
    ///   - quantity: The quantity.
    ///   - price: Optional. The price.
    ///   - brand: Optional. The product brand. Defaults to nil.
    ///   - category: Optional. The product category. Defaults to nil.
    ///   - couponCode: Optional. The coupon associated with the product. Defaults to nil.
    ///   - variant: Optional. The product variant. Defaults to nil.
    ///   - position: Optional. The position of the product. Defaults to nil.
    ///   - properties: Optional. The properties. Defaults to nil.
    public init(productName: String,
                productId: String,
                quantity: Int,
                price: Double?,
                brand: String? = nil,
                category: String? = nil,
                couponCode: String? = nil,
                variant: String? = nil,
                position: UInt? = nil,
                properties: Properties?) {
        self.productName = productName
        self.productId = productId
        self.quantity = quantity
        self.price = price
        self.brand = brand
        self.category = category
        self.couponCode = couponCode
        self.variant = variant
        self.position = position
        self.properties = properties
    }
}
