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

internal class AnalyticsTracker {
    
    var providers: [AnalyticsTracking]
    
    var actions: [TrackerAction]
    
    var name: String
    
    init(providers: [AnalyticsTracking], actions: [TrackerAction], name: String) {
        self.providers = providers
        self.actions = actions
        self.name = name
    }
}

internal protocol TrackerAction {
    
    var name: String { get }
    
    func track()
}

internal class EventTrackerAction: TrackerAction {
    
    var name: String {
        return "Track Event"
    }
    
    func track() {
        var eventDataProperties: Properties = MPEvent.eventData(type: .other, name: "")
        eventDataProperties["Location"] = "Tracker Page"
        
        Simcoe.track(event: "Tapped Track Event", withAdditionalProperties: eventDataProperties)
    }
}

internal class LifetimeValueIncreasingAction: TrackerAction {
    
    var name: String {
        return "Track Lifetime Value Increase"
    }
    
    func track() {
        let properties: Properties = ["Location" : "Tracker Page"]
        Simcoe.trackLifetimeIncrease(byAmount: 1,
                                     forItem: "Track Lifetime Value Tapped",
                                     withAdditionalProperties: properties)
    }
}

internal class LocationTrackingAction: TrackerAction {
    
    var name: String {
        return "Track Location"
    }
    
    func track() {
        let properties: Properties = ["Location" : "Tracker Page"]
        let location = CLLocation(latitude: 40.7128, longitude: 74.0059)
        Simcoe.track(location: location, withAdditionalProperties: properties)
    }
}

internal class PageViewTrackingAction: TrackerAction {
    
    var name: String {
        return "Track Page View"
    }
    
    func track() {
        let properties: Properties = ["Location" : "Tracker Page"]
        Simcoe.track(pageView: "Tracker Selection Page View", withAdditionalProperties: properties)
    }
}

internal final class AnalyticsDisplayViewController: UITableViewController {
    
    var providers: [AnalyticsTracker] = []
    
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
        let actions: [TrackerAction] = [EventTrackerAction(),
                                        LocationTrackingAction(),
                                        LifetimeValueIncreasingAction(),
                                        PageViewTrackingAction()]
        
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
        
        Simcoe.run(with: providers[indexPath.row].providers)
        
        trackerVC.trackers = providers[indexPath.row].actions
        navigationController?.pushViewController(trackerVC, animated: true)
    }
}
