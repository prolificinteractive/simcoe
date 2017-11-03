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
    /// - Parameter product: A SimcoeProductConvertible instance.
    internal convenience init(product: SimcoeProductConvertible) {
        let simcoeProduct = product.toSimcoeProduct()
        self.init(name: simcoeProduct.productName,
                  // INTENTIONAL: In MPProduct: SKU of a product. This is the product id
                  sku: simcoeProduct.productId,
                  quantity: NSNumber(value: simcoeProduct.quantity),
                  price: NSNumber(value: simcoeProduct.price ?? 0))
        self.brand = simcoeProduct.brand
        self.category = simcoeProduct.category
        self.couponCode = simcoeProduct.couponCode
        self.variant = simcoeProduct.variant

        if let position = simcoeProduct.position {
            self.position = position
        }

        guard let properties = simcoeProduct.properties else {
            return
        }

        let remaining = MPProductKeys.remaining(properties: properties)

        for (key, value) in remaining {
            if let value = value as? String {
                self[key] = value
            }
        }
    }

}
