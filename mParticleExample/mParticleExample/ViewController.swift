//
//  ViewController.swift
//  mParticleExample
//
//  Created by Christopher Jones on 2/19/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import Simcoe
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Simcoe.run()
        Simcoe.track(pageView: "Main")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tap(_ sender: AnyObject) {
        Simcoe.track(event: "Button Tap")
    }

}
