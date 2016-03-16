# Adobe

The adobe subspec provides a default implementation for common Adobe functions within Simcoe.

## Requirements

The Adobe implementation of Simcoe requires:

- Simcoe Core framework
- AdobeMobileSDK (4.8 +)

The AdobeMobileSDK framework is included as part of the subspec.

## Usage

This subspec adds the `Adobe` class to your Simcoe framework; this class implements the base features for Simcoe within the Adobe framework.

To track analytics using Adobe, include it as part of your initial `run` call:

```swift
Simcoe.run(with: [Adobe()])
```

Adobe automatically implements the following protocols:

- `AnalyticsTracking`
- `PageViewTracking`
- `EventTracking`
- `LifetimeValueIncreasing`
- `LocationTracking`


## Subclassing

The `Adobe` class is able to be subclassed. If you are overriding any Simcoe methods, it is advised that you do _not_ call `super` on them
as you may make analytics calls more than once.
