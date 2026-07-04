# Platform Support

HIGDesign ships one Swift package for six Apple platforms. Components use `HIGPlatform` helpers and token fallbacks when a control is unavailable on a given OS.

## Minimum deployments

| Platform | Minimum |
|----------|---------|
| iOS / iPadOS | 18 |
| macOS | 15 |
| visionOS | 2 |
| tvOS | 18 |
| watchOS | 11 |

Swift 6 and SwiftUI are required. UIKit is not used.

## Platform-specific components

Some components are limited to platforms where the underlying HIG pattern applies:

| Component | Platforms |
|-----------|-----------|
| ``HIGPhotoPicker`` | iOS |
| ``HIGPhotoEditor`` | iOS |
| ``HIGSegmentedControl``, ``HIGTabBar`` | iOS, iPadOS, macOS, visionOS, tvOS |
| ``HIGSlider`` | iOS, iPadOS, macOS, visionOS |
| ``HIGSidebar`` | iOS, iPadOS, macOS, visionOS |

All other shipped components target every supported platform.

## Showcase snapshots

Committed renders under `Design/Showcase/snapshots/` include a theme matrix (system, high contrast, brand × light/dark) and per-platform canvases under `snapshots/platforms/`.

Regenerate locally:

```bash
Scripts/capture_showcase_snapshots.sh
```

## Related

- <doc:ShowcaseApp>
- <doc:Components>