//
//  Product.swift
//  mParticleExample
//
//  Created by Michael Campbell on 10/25/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import Simcoe

struct ExampleProduct {

    /// The product name.
    let name: String

    /// The product Id.
    let id: String

    /// The quantity.
    let quantity: Int

    /// The price.
    let price: Double?

    /// The properties.
    let properties: Properties?

}

extension ExampleProduct: SimcoeProductConvertible {

    func toSimcoeProduct() -> SimcoeProduct {
        return SimcoeProduct(productName: name,
                             productId: id,
                             quantity: quantity,
                             price: price,
                             properties: properties)
    }
    
}
