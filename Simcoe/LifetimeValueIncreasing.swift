//
//  LifetimeValueIncreasing.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/16/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

public protocol LifetimeValueIncreasing: AnalyticsTracking {

    func increaseLifetimeValue(forKey key: String, amount: Int)
    
}
