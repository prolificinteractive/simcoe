//
//  UIViewControllerExtension.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/23/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static var storyboardID: String {
        return String(describing: self)
    }
}
