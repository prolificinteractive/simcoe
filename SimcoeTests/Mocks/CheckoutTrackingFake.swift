//
//  CheckoutTrackingFake.swift
//  Simcoe
//
//  Created by Michael Campbell on 11/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class CheckoutTrackingFake: CheckoutTracking, Failable {

    let name = "Checkout Tracking [Fake]"

    var shouldFail = false

    var checkoutEventCount = 0

    func trackCheckoutEvent<T : SimcoeProductConvertible>(products: [T], eventProperties: Properties?) -> TrackingResult {
        checkoutEventCount += 1

        if shouldFail {
            return .Error(message: "Error")
        }

        return .Success
    }

}
