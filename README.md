![Simcoe](Images/Simcoe_logo.jpg)

[![Travis build status](https://img.shields.io/travis/prolificinteractive/Simcoe.svg?style=flat-square)](https://travis-ci.org/prolificinteractive/Simcoe)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/Simcoe.svg?style=flat-square)](https://img.shields.io/cocoapods/v/Simcoe.svg)
[![Platform](https://img.shields.io/cocoapods/p/Simcoe.svg?style=flat-square)](http://cocoadocs.org/docsets/Simcoe)
[![Docs](https://img.shields.io/cocoapods/metrics/doc-percent/Simcoe.svg?style=flat-square)](http://cocoadocs.org/docsets/Simcoe)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Description

A light analytics wrapper aimed at making analytics implementation & debugging as simple and
streamlined as possible -- especially for projects utilizing multiple analytics providers.

## Requirements

Simcoe is written in Swift and utilizes dynamic frameworks for its implementation. As such, this
library requires:

* Xcode 8 or greater
* iOS 8 or greater

## Installation

Simcoe is made up of a core framework with additional plugins available for a variety of different analytics providers.

### CocoaPods
Simcoe is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod "Simcoe"
```

This will give you the core SDK with the default debugging capabilities right out of the box. However, you
will be responsible for creating the analytics provider. Simcoe comes with a variety of provider implementations
right out of the box, however, that can reduce the amount of work you need to do to get started. Simply include the relevant subspec in your Podfile; for instance, if your project was using Adobe Omniture to
track analytics, simply specify the subspec in your project's Podfile:

``
pod 'Simcoe', :subspecs => ['Adobe']
``

### Carthage
You can also add Simcoe to your project using [Carthage](https://github.com/Carthage/Carthage). Add the following to your `Cartfile`:

```ruby
github "prolificinteractive/Simcoe"
```

## Included Providers

Simcoe comes with default implementations for a wide-variety of providers right out of the box:

* [Adobe](Simcoe/Adobe/README.md)
* [mParticle](Simcoe/mParticle/README.md)


## Usage

Using Simcoe is simple. At the start of your application's lifecycle, simply begin running Simcoe with the providers you wish to use:

`Simcoe.run(with: Adobe())`

If you do not yet know which analytics tool your project will be using, that's fine! Simply start Simcoe without arguments:

`Simcoe.run()`

By default, if Simcoe is not given any providers, it will automatically create a default provider to use as a placeholder. This allows you to implement, track, and debug analytics without a provider. Then, when your
provider changes, simply update your `run()` call with the providers and that's it!

Simcoe providers a base function call for each major analytics action right out of the gate, giving a consistent API to all of your analytics tracking. For instance, to track page views:

``
Simcoe.trackPageView("Home Screen")
``

That's it! Simcoe will automatically call all of your analytics providers and request that they log that page view. This same method is uniform and consistent, no matter what providers you are using.


### Creating an Analytics Provider

While Simcoe comes with some analytics implementations right out of the box, sometimes you will need to roll your own. The Simcoe API makes it easy for anyone to do.

#### AnalyticsTracking

First, all analytics trackers implement this base protocol: `AnalyticsTracking`. This protocol is the only that is needed for any object to be considered a valid analytics tracker to Simcoe. This protocol allows you to define a user-readable name for your provider as well as the ability to begin or handle any setup work that your tracker requires.

While simply implementing this protocol is all you need for your object to be a valid analytics tracker, you won't be able to do too much with it. This is because Simcoe utilizes an array of various different protocols, each one giving defining the functionality needed to handle that API event. These protocols are:

* `CartLogging`
* `CheckoutTracking`
* `ErrorLogging`
* `EventTracking`
* `LifetimeValueIncreasing`
* `LocationTracking`
* `PageViewTracking`
* `UserAttributeTracking`

So for your analytics provider to be able to handle page views in the Simcoe framework, your provider should implement the `PageViewTracking` protocol. This plug-and-play API allows you to define what you want your provider to handle at a very granular level. If your provider only needs to implement location tracking and nothing else, then you need only implement the `LocationTracking` protocol (as well as the `AnalyticsTracking` protocol, of course); all other protocols are optional. This allows you full customization as to how your objects respond to Simcoe.

Each provider type defined above maps directly to a Simcoe function that will call that method. These are, respectively:

* `logAddToCart`, `logRemoveFromCart`
* `trackCheckoutEvent`
* `logError`
* `trackEvent`
* `increaseLifetimeValue`
* `trackLocation`
* `trackPageView`
* `setUserAttribute`


#### Additional Tracking

Each analytics implementation is different, and Simcoe doesn't expect to be the be-all, end-all of analytics implementations. What if you need to track something that is not included in the base SDK?

Ultimately, all tracking calls in `Simcoe` are forwarded to the default singleton: `Simcoe.engine` which publicly exposes the one tracking method: `write`. This function takes an array of all objects, a description
of the event, and a closure to actually do the write event. Using this method will allow you to handle any type of custom analytics work you may need to do while also continuing to utilize the powerful debug and logging
tools provided by the Simcoe framework.

Let's say, for example, you are using Sqweeblytics to track the amount of Sqweebles in your application. This is clearly unique behavior, but it's important analytics data.

All you would need to do is wrap your Sqweeblytics provider in the Simcoe engine:

```
Simcoe.engine.write(toProviders: [Sqweeblytics()],
    description: "Tracks all of the user's sqweebles.",
    action: { sqweeblytics in
        sqweeblytics.track()
        return .Success
})
```

That's it! You are now able to properly track your sqweebles while continuing to utilize the Simcoe engine.

## Contributing to Simcoe

To report a bug or enhancement request, feel free to file an issue under the respective heading.

If you wish to contribute to the project, fork this repo and submit a pull request. Code contributions should follow the standards specified in the [Prolific Swift Style Guide](https://github.com/prolificinteractive/swift-style-guide).

## License

![prolific](https://s3.amazonaws.com/prolificsitestaging/logos/Prolific_Logo_Full_Color.png)

Copyright (c) 2016 Prolific Interactive

Simcoe is maintained and sponsored by Prolific Interactive. It may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: ./LICENSE
