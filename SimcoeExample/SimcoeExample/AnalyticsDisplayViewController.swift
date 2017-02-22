//
//  AnalyticsDisplayViewController.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import UIKit
import Simcoe
import CoreLocation
import mParticle_Apple_SDK

internal final class TrackerActionGenerator {
    
    func trackerActions(providers: [AnalyticsTracking]) -> [TrackerAction] {
        var actions: [TrackerAction] = []
        
        for provider in providers {
            
        }
        
        return actions
    }
}

internal final class AnalyticsDisplayViewController: UITableViewController {
    
    var providers: [AnalyticsTracker] = []
    
    lazy var analyticsEngine: AnalyticsEngine = {
        return SimcoeAnalyticsEngine()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let particle = mParticle(key: "ef79020ccbbfcf198717de75f0a406b4", secret: "0195e9e766b5b87aa2095d926f1d527e")
        let adobe = Adobe()
        
        setupTrackers(providers: [adobe], name: adobe.name)
        setupTrackers(providers: [particle], name: particle.name)
        setupTrackers(providers: [adobe, particle], name: "All Analytics Trackers")
        setupTrackers(providers: [], name: "None")
    }
    
    private func setupTrackers(providers: [AnalyticsTracking], name: String) {
        let actions: [TrackerAction] = [EventTrackerAction(engine: analyticsEngine),
                                        LocationTrackingAction(engine: analyticsEngine),
                                        LifetimeValueIncreasingAction(engine: analyticsEngine),
                                        PageViewTrackingAction(engine: analyticsEngine)]
        
        self.providers.append(AnalyticsTracker(providers: providers, actions: actions, name: name))
    }
}

extension AnalyticsDisplayViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = providers[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let trackerVC = TrackerTableViewController.storyboardInit()
        
        analyticsEngine.run(with: providers[indexPath.row].providers)
        
        trackerVC.trackers = providers[indexPath.row].actions
        navigationController?.pushViewController(trackerVC, animated: true)
    }
}
