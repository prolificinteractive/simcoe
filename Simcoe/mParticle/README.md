# mParticle

The mParticle subspec provides a default implementation for common mParticle functions within Simcoe.

## Requirements

The mParticle implementation of Simcoe requires:

- Simcoe Core framework
- mParticle-Apple-SDK/mParticle (6+)

The mParticle-Apple-SDK/mParticle framework is included as part of the subspec.

## Usage

This subspec adds the `mParticle` class to your Simcoe framework; this class implements the base features for Simcoe within the mParticle framework.

To track analytics using mParticle, include it as part of your initial `run` call:

```swift
Simcoe.run(with: [mParticle()])
```

mParticle automatically implements the following protocols:

- `AnalyticsTracking`
- `CartLogging`
- `CheckoutTracking`
- `ErrorLogging`
- `EventTracking`
- `LifetimeValueTracking`
- `LocationTracking`
- `PageViewTracking`
- `PurchaseTracking`
- `TimedEventTracking`
- `UserAttributeTracking`
- `ViewDetailLogging`

## MPEvent

Because of the complex nature of mParticle tracking, a few helper functions have been added to make logging mParticle events easier within the Simcoe framework.

For `EventTracking` and `LocationTracking`, mParticle expects an `MPEvent` object be passed. Because Simcoe is built to be abstract, it is unable to fit `MPEvent` into its interface. As a result, the mParticle subspec includes a helper method `eventData()` that you can use to create an MPEvent dictionary that Simcoe recognizes.

```swift
public func eventData(type type: MPEventType, name: String, category: String? = nil,
    duration: Float? = nil, startTime: Date? = nil,
    endTime: Date? = nil, customFlags: [String: [String]]? = nil,
    info: Properties? = nil) -> Properties
```

The two mandatory items for every `MPEvent` object are `type` and `name`, both of which are non-optional parameters. All other items of `MPEvent` are optional
and should be filled in as desired for each event. This function returns a dictionary which you can then pass directly to Simcoe. The mParticle framework
within Simcoe will then handle the unpacking of this dictionary.

Any mParticle tracking function that does not properly receive an event dictionary from `eventData` will fail and throw an error.

## Subclassing

As Simcoe moves toward more composition over inheritance, the `mParticle` class is not subclassable.
