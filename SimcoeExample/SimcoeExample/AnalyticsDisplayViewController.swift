//
//  AnalyticsDisplayViewController.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import UIKit

internal final class AnalyticsDisplayViewController: UITableViewController {
    
    var analyticsEngine: AnalyticsEngine!
    
    var providers: AnalyticsProviders!
}

extension AnalyticsDisplayViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers.trackers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = providers.trackers[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let trackerVC: TrackerTableViewController = TrackerTableViewController.storyboardInit()
        
        analyticsEngine.run(with: providers.trackers[indexPath.row].providers)
        
        trackerVC.trackers = providers.trackers[indexPath.row].actions
        navigationController?.pushViewController(trackerVC, animated: true)
    }
}

extension AnalyticsDisplayViewController {
    
    static func storyboardInit<T>() -> T {
        return UIStoryboard.mainStoryboard.instantiateViewController(AnalyticsDisplayViewController.storyboardID)
    }
}
