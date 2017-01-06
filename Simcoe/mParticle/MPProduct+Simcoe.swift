//
//  MPProduct+Simcoe.swift
//  Simcoe
//
//  Created by Michael Campbell on 10/25/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import mParticle_Apple_SDK

extension MPProduct {

    /// A convenience initializer.
    ///
    /// - parameter product: A SimcoeProductConvertible instance.
    ///
    /// - returns: A MPProduct.
    internal convenience init(product: SimcoeProductConvertible) {
        let simcoeProduct = product.toSimcoeProduct()
        self.init(name: simcoeProduct.productName,
                  // INTENTIONAL: In MPProduct: SKU of a product. This is the product id
                  sku: simcoeProduct.productId,
                  quantity: simcoeProduct.quantity,
                  price: simcoeProduct.price)

        guard let properties = simcoeProduct.properties else {
            return
        }

        if let brand = properties[MPProductKeys.Brand.rawValue] as? String {
            self.brand = brand
        }

        if let category = properties[MPProductKeys.Category.rawValue] as? String {
            self.category = category
        }

        if let couponCode = properties[MPProductKeys.CouponCode.rawValue] as? String {
            self.couponCode = couponCode
        }

        if let sku = properties[MPProductKeys.Sku.rawValue] as? String {
            // INTENTIONAL: In MPProduct: The variant of the product
            self.variant = sku
        }

        if let position = properties[MPProductKeys.Position.rawValue] as? UInt {
            self.position = position
        }
        
        let remaining = MPProductKeys.remainingProperties(properties)
        
        for (key, value) in remaining {
            if let value = value as? String {
                self[key] = value
            }
        }
    }
    
}
