//
//  MPProductKeys.swift
//  Simcoe
//
//  Created by Michael Campbell on 9/9/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The MPProduct keys available for use with additionalProperties.
///
/// - brand: The product brand.
/// - category: A category to which the product belongs.
/// - couponCode: The coupon associated with the product.
/// - sku: The sku of the product.
/// - position: The position of the product on the screen or impression list.
/// - variant: The variant.
public enum MPProductKeys: String, EnumerationListable {

    case brand = "brand"
    case category = "category"
    case couponCode = "couponCode"
    case sku = "sku"
    case position = "position"

    static let allKeys: [MPProductKeys] = [.brand, .category, .couponCode, .sku, .position]

}
