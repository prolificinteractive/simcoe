//
//  UserAttributesFake.swift
//  Simcoe
//
//  Created by John Lin on 5/17/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

@testable import Simcoe

internal final class UserAttributesFake: UserAttributeTracking {
    
    let name = "User Attributes [Fake]"
    
    var attributesCallCount = 0
    
    func setUserAttribute(_ key: String, value: Any) -> TrackingResult {
        attributesCallCount += 1
        return .success
    }

    func setUserAttributes(_ attributes: Properties) -> TrackingResult {
        attributes.forEach { _ in
            attributesCallCount += 1
        }
        return .success
    }
    
}
