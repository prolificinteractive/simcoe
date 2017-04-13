//
//  PurchaseTrackingFake.swift
//  Simcoe
//
//  Created by Yoseob Lee on 2/27/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class PurchaseTrackingFake: PurchaseTracking {

    let name = "Purchase Tracking [Fake]"

    var purchaseEventCount = 0

    func trackPurchaseEvent<T : SimcoeProductConvertible>(_ products: [T], eventProperties: Properties?) -> TrackingResult {
        purchaseEventCount += 1
        return .success
    }

}
