//
//  UIStoryboardExtension.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/23/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static var trackerStoryboard: UIStoryboard {
        return UIStoryboard(name: "Tracker", bundle: nil)
    }
    
    func instantiateViewController<T>(_ identifier: String) -> T {
        return self.instantiateViewController(withIdentifier: identifier) as! T
    }
}
