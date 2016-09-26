//
//  SimcoeProductConvertible.swift
//  Simcoe
//
//  Created by Michael Campbell on 10/25/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The product convertible protocol.
public protocol SimcoeProductConvertible {

    /// Converts a product to a Simcoe Product.
    ///
    /// - returns: A SimcoeProduct
    func toSimcoeProduct() -> SimcoeProduct
    
}
