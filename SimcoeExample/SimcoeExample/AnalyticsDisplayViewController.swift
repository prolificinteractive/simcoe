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

internal protocol ActionGenerator {
    
    func trackerActions(providers: [AnalyticsTracking]) -> [TrackerAction]
    
}

internal final class TrackerActionGenerator: ActionGenerator {
    
    private var engine: AnalyticsEngine
    
    private var availableTrackerActions: [TrackerAction]
    
    init(engine: AnalyticsEngine, availableTrackerActions: [TrackerAction]) {
        self.engine = engine
        self.availableTrackerActions = availableTrackerActions
    }
    
    func trackerActions(providers: [AnalyticsTracking]) -> [TrackerAction] {
        var actions: [TrackerAction] = []
        
        for provider in providers {
            for action in availableTrackerActions {
                if action.isActionAvailable(provider: provider) == true &&
                    action.isContainedIn(actions: actions) == false {
                
                    actions.append(action)
                }
            }
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
        
        let particle = mParticle(key: "mikesaidtomakeafakeone", secret: "hiyoseob")
        let adobe = Adobe()
        
        setupTrackers(providers: [adobe], name: adobe.name)
        setupTrackers(providers: [particle], name: particle.name)
        setupTrackers(providers: [adobe, particle], name: "All Analytics Trackers")
        setupTrackers(providers: [], name: "None")
    }
    
    private func setupTrackers(providers: [AnalyticsTracking], name: String) {
        
        let availableActions: [TrackerAction] = [EventTrackerAction(engine: analyticsEngine),
                                                 LocationTrackingAction(engine: analyticsEngine),
                                                 LifetimeValueIncreasingAction(engine: analyticsEngine),
                                                 PageViewTrackingAction(engine: analyticsEngine)]
        
        guard !providers.isEmpty else {
            self.providers.append(AnalyticsTracker(providers: providers, actions: availableActions, name: name))
            return
        }
        

        let actionGenerator = TrackerActionGenerator(engine: analyticsEngine, availableTrackerActions: availableActions)
        let actions = actionGenerator.trackerActions(providers: providers)
        
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
