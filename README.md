# Simcoe

A light analytics wrapped aimed at making analytics implementation and debugging as simple and
streamlined as possible -- especially for projects utilizing multiple analytics providers.

## Requirements

Simcoe is written in Swift and utilizes dynamic frameworks for its immplementation. As such, this 
library requires:

* Xcode 7 or greater
* iOS8 or greater

## Installation

Simcoe is best utilized via Cocoapods.

Simcoe is made up of a core framework with additional plugins available for a variety of different
analytics provider. For just the core implementation of Simcoe, simply include in your Podfile:

``
pod 'Simcoe'
``

This will give you the core SDK with the default debugging capabilities right out of the box. However, you
will be responsible for creating the analytics provider. Simcoe comes with a variety of provider implementations 
right out of the box, however, that can reduce the amount of work you need to do to get started. Simply
include the relevant subspec in your Podfile; for instance, if your project was using Adobe Omniture to
track analytics, simply specify the subspec in your project's Podfile:

``
pod 'Simcoe', :subspecs => ['Adobe']
``

## Included Providers

Simcoe comes with default implementations for a wide-variety of providers right out of the box:

* Adobe
* mParticle


## Usage

Using Simcoe is simple. At the start of your application's lifecycle, simply begin running Simcoe with the
providers you wish to use:

`Simcoe.run(with: Adobe())`

If you do not yet know which analtytics tool your project will be using, that's fine! Simply start Simcoe
the same way:

`Simcoe.run()`

By default, if Simcoe is not given any providers, it will automatically create a default provider to use as a 
placeholder. This allows you to implement, track, and debug analytics without a provider. Then, when your
provider changes, simply update your `run` call with the providers and that's it!

Simcoe providers a base function call for each major analytics action right out of the gate, giving a
consistent API to all of your analytics tracking. For instance, to track page views:

``
Simcoe.trackPageView("Home Screen")
``

That's it! Simcoe will automatically call all of your analytics providers and request that they log that
page view. This same method is uniform and consistent, no matter what providers you are using.


## Creating an Analytics Provider

While Simcoe comes with some analytics implementations right out of the box, sometimes you will need to roll
your own. The Simcoe API makes it easy for anyone to do.

### AnalyticsTracking

First, all analytics trackers implement this base protocol: `AnalyticsTracking`. This protocol is the only that is 
needed for any object to be considered a valid analytics tracker to Simcoe. This protocol allows you to define
a user-readable name for your provider as well as the ability to begin or handle any setup work that your 
tracker requires.

While simply implementing this protocol is all you need for your object to be a valid analytics tracker,
you won't be able to do too much with it. This is because Simcoe utilizes an array of various different 
protocols, each one giving defining the functionality needed to handle that API event. These protocols are:

* `PageViewTracking`
* `EventTracking`
* `LifetimeValueIncreasing`
* `LocationTracking`

So for your analytics provider to be able to handle page views in the Simcoe framework, your provider should 
implement the `PageViewTracking` protocol. This plug-and-play API allows you to define what you want your provider
to handle at a very granular level. If your provider only needs to implement location tracking and nothing else, then
you need only implement the `LocationTracking` protocol (as well as the `AnalyticsTracking` protocol, of course); all 
other protocols are optional. This allows you full customization as to how your objects respond to Simcoe.

Each provider type defined above maps directly to a Simcoe function that will call that method. These are, respectively:

* `trackPageView`
* `trackEvent`
* `increaseLifetimeValue`
* `trackLocation`


## Additional Tracking

Each analytics implementation is different, and Simcoe doesn't expect to be the be-all, end-all of 
analytics implementations. What if you need to track something that is not included in the base SDK?

Ultimately, all tracking calls in `Simcoe` are forwarded to the default singleton: `Simcoe.engine` which
publicly exposes the one tracking method: `write`. This function takes an array of all objects, a description
of the event, and a closure to actually do the write event. Using this method will allow you to handle any 
type of custom analytics work you may need to do while also continuing to utilize the powerful debug and logging
tools provided by the Simcoe framework.

Let's say, for example, you are using Squeeblytics to track the amount of Squeebles in your application. This is 
clearly unique behavior, but it's important analytics data.

All you would need to do is wrap your Squeeblytics provider in the Simcoe engine:

```
Simcoe.engine.write(toProviders: [Squeeblytics()],
    description: "Tracks all of the user's squeebles.",
    action: { squeeblytics in
        squeeblytics.track()
        return .Success
})
```

That's it! You are now able to properly track your squeebles while continuing to utilize the Simcoe engine.
