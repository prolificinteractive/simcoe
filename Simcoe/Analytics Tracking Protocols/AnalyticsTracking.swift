//
//  AnalyticsProvider.swift
//  Simcoe
//
//  Created by Christopher Jones on 2/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// Default protocol for an object being trackable for analytics. All analytics items that wish to
/// be tracked must, at least, implement this protocol.
public protocol AnalyticsTracking {

    /// The name of the tracker. This is used for debugging purposes only, but should
    /// be reflective of the tool you are using to track analytics.
    /// For instance, if you are using Adobe Omniture, it is recommended that this value
    /// return "Adobe Omniture".
    var name: String { get }


    /// Starts tracking analytics. This is called on all providers passed to `Simcoe.run`.
    /// Your analytics tracker should start tracking lifecycle data or setup anything else
    /// that needs to run for the duration of the analytics lifecycle.
    ///
    /// This is an optional value and is implemented by default in an extension to do nothing.
    func start()

    /// Force push all tracking events. This should be called before the application terminates or 
    /// enters the background. Some providers suggest that a flush event should be called to make
    /// sure events are fired before the application dismisses; else they may fire at the next
    /// start of the app.
    ///
    /// This is an optional value and is implemented by default in an extension to do nothing.
    func flush()

}

public extension AnalyticsTracking {

    /// Starts tracking analytics. This is called on all providers passed to `Simcoe.run`.
    /// Your analytics tracker should start tracking lifecycle data or setup anything else
    /// that needs to run for the duration of the analytics lifecycle.
    ///
    /// This is an optional value and is implemented by default in an extension to do nothing.
    func start() {

    }

    /// Force push all tracking events. This should be called before the application terminates or
    /// enters the background. Some providers suggest that a flush event should be called to make
    /// sure events are fired before the application dismisses; else they may fire at the next
    /// start of the app.
    ///
    /// This is an optional value and is implemented by default in an extension to do nothing.
    func flush() {

    }

}
