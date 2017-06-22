//
//  SimcoeExampleApplication.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/23/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import UIKit

internal class SimcoeExampleApplication {
    
    func startWindow() -> UIWindow {
        let window = UIWindow()
        
        let rootViewController = AnalyticsDisplayBuilder().analyticsDisplayViewController()
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        
        window.rootViewController = navigationViewController
        
        return window
    }
}
