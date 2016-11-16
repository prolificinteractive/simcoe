//
//  CartLoggingFake.swift
//  Simcoe
//
//  Created by Michael Campbell on 11/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class CartLoggingFake: CartLogging, Failable {

    let name = "Cart Logging [Fake]"

    var shouldFail = false

    var cartAdditionCount = 0
    var cartRemovalCount = 0

    func logAddToCart<T: SimcoeProductConvertible>(product: T, eventProperties: Properties?) -> TrackingResult {
        cartAdditionCount += 1

        if shouldFail {
            return .Error(message: "Error")
        }

        return .Success
    }

    func logRemoveFromCart<T : SimcoeProductConvertible>(product: T, eventProperties: Properties?) -> TrackingResult {
        cartRemovalCount += 1

        if shouldFail {
            return .Error(message: "Error")
        }

        return .Success
    }

}
