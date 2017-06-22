//
//  TrackerTableViewController.swift
//  SimcoeExample
//
//  Created by Jonathan Samudio on 2/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import UIKit
import Simcoe

internal final class TrackerTableViewController: UITableViewController {
    
    var trackers: [TrackerAction]!
}

extension TrackerTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = trackers[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        trackers[indexPath.row].track()
    }
}

extension TrackerTableViewController {
    
    static func storyboardInit<T>() -> T {
        return UIStoryboard.trackerStoryboard.instantiateViewController(TrackerTableViewController.storyboardID)
    }
}
