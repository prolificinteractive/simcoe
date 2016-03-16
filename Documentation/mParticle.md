# mParticle

The mParticle subspec provides a default implementation for common mParticle functions within Simcoe.

## Requirements

The mParticle implementation of Simcoe requires:

- Simcoe Core framework
- mParticle-iOS-SDK/mParticle (5.3+)

The mParticle-iOS-SDK/mParticle framework is included as part of the subspec.

## Usage

This subspec adds the `mParticle` class to your Simcoe framework; this class implements the base features for Simcoe within the mParticle framework.

To track analytics using mParticle, include it as part of your initial `run` call:

```swift
Simcoe.run(with: [mParticle()])
```

mParticle automatically implements the following protocols:

- `AnalyticsTracking`
- `PageViewTracking`
- `EventTracking`
- `LifetimeValueIncreasing`
- `LocationTracking`

## MPEvent

Because of the complex nature of mParticle tracking, a few helper functions have been added to make logging mParticle events easier within the Simcoe framework.

For `EventTracking` and `LocationTracking`, mParticle expects an `MPEvent` object be passed. Because Simcoe is built to be abstract, it is unable to fit `MPEvent` 
into its interface. As a result, the mParticle subspec includes a helper method `eventData()` that you can use to create an MPEvent dicitonary that Simcoe recognizes.

```swift
public func eventData(type type: MPEventType, name: String, category: String? = nil,
    duration: Float? = nil, startTime: NSDate? = nil,
    endTime: NSDate? = nil, customFlags: [String: [String]]? = nil,
    info: [String: AnyObject]? = nil) -> [String: AnyObject] 
```

The two mandatory items for every `MPEvent` object are `type` and `name`, both of which are non-optional parameters. All other items of `MPEvent` are optional
and should be filled in as desired for each event. This function returns a dictionary which you can then pass directly to Simcoe. The mParticle framework
within Simcoe will then handle the unpacking of this dictionary.

Any mParticle tracking function that does not properly receive an event dictionary from `eventData` will fail and throw an error.

## Subclassing

The `Adobe` class is able to be subclassed. If you are overriding any Simcoe methods, it is advised that you do _not_ call `super` on them
as you may make analytics calls more than once.
