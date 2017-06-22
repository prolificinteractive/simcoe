//
//  AppDelegate.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = SimcoeExampleApplication().startWindow()
        return true
    }
}
