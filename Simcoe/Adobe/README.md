# Adobe

The adobe subspec provides a default implementation for common Adobe functions within Simcoe.

## Requirements

The Adobe implementation of Simcoe requires:

- Simcoe Core framework
- AdobeMobileSDK (4.8 +)

The AdobeMobileSDK framework is included as part of the subspec.

## Usage

This subspec adds the `Adobe` class to your Simcoe framework; this class implements the base features for Simcoe within the Adobe framework.

To track analytics using Adobe, include it as part of your initial `run()` call:

```swift
Simcoe.run(with: [Adobe()])
```

Adobe automatically implements the following protocols:

- `AnalyticsTracking`
- `PageViewTracking`
- `EventTracking`
- `LifetimeValueTracking`
- `LocationTracking`

## Subclassing

As Simcoe moves toward more composition over inheritance, the `Adobe` class is not subclassable.
