# Mixpanel

The Mixpanel subspec provides a default implementation for common Mixpanel functions within Simcoe.

## Requirements

The Mixpanel implementation of Simcoe requires:

- Simcoe Core framework
- Mixpanel-swift (2.1 +)

The Mixpanel-swift framework is included as part of the subspec.

## Usage

This subspec adds the `MixpanelPlaceholder` class to your Simcoe framework; this class implements the base features for Simcoe within the Mixpanel framework.

To track analytics using Mixpanel, include it as part of your initial `run()` call:

```swift
Simcoe.run(with: [MixpanelPlaceholder()])
```

Mixpanel automatically implements the following protocols:

- `AnalyticsTracking`
- `EventTracking`
- `LifetimeValueIncreasing`
- `SuperPropertyTracking`
- `UserAttributeTracking`

## Subclassing

As Simcoe moves toward more composition over inheritance, the `MixpanelPlaceholder` class is not subclassable.
