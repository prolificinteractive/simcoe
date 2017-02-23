//
//  AnalyticsDisplayBuilder.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/23/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import Simcoe

internal class AnalyticsDisplayBuilder {
    
    let analyticsEngine: AnalyticsEngine = SimcoeAnalyticsEngine()
    
    lazy var availableTrackers: AvailableTrackers = {
        return AvailableTrackers(engine: self.analyticsEngine)
    }()
    
    lazy var providers: AnalyticsProviders = {
        return AnalyticsProviders(engine: self.analyticsEngine, availableActions: self.availableTrackers.actions)
    }()
    
    init() {
        let particle = mParticle(key: "mikesaidtomakeafakeone", secret: "hiyoseob")
        let adobe = Adobe()
        
        providers.addTracker(name: adobe.name, providers: [adobe])
        providers.addTracker(name: particle.name, providers: [particle])
        providers.addTracker(name: "All Analytics Trackers", providers: [adobe, particle])
        providers.addTracker(name: "None", providers: [])
    }
    
    func analyticsDisplayViewController() -> AnalyticsDisplayViewController {
        let rootViewController: AnalyticsDisplayViewController = AnalyticsDisplayViewController.storyboardInit()
        rootViewController.analyticsEngine = analyticsEngine
        rootViewController.providers = providers
        
        return rootViewController
    }
}
