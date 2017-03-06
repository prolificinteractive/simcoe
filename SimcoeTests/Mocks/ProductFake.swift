//
//  ProductFake.swift
//  Simcoe
//
//  Created by Michael Campbell on 11/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal struct ProductFake {

    let name: String = "Fake Product"

    let id: String = "3274856324328"

    let numberOfItems: Int = 2

    let totalPrice: Double = 935.47

    let properties: Properties = [ "sku": 348956743 as Int,
                                   "brand": "super" as String]

}

extension ProductFake: SimcoeProductConvertible {

    func toSimcoeProduct() -> SimcoeProduct {
        return SimcoeProduct(productName: name,
                             productId: id,
                             quantity: numberOfItems,
                             price: totalPrice,
                             properties: properties)
    }

}
