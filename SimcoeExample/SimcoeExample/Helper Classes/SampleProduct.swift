//
//  SampleProduct.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/23/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe

struct SampleProduct: SimcoeProductConvertible {
    
    func toSimcoeProduct() -> SimcoeProduct {
        return SimcoeProduct(productName: "Fancy Dress", productId: "256489", quantity: 2, price: 100, properties: nil)
    }
}
