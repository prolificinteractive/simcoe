//
//  TrackerAction.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

internal protocol TrackerAction {
    
    var name: String { get }
    
    func track()
}
