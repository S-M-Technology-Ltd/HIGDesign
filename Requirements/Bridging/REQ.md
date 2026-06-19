# Bridging Requirements

## Summary

Optional SwiftUI bridges for platform gaps. Bridging is a separate product and must not be required for core HIG components unless explicitly approved. UIKit representables are not permitted.

## All platforms

### Purpose

- Provide bridged controls only where native SwiftUI cannot meet HIG behavior.
- Adapt patterns from SwiftUIX without adding a runtime dependency on SwiftUIX unless explicitly approved.
- Style all bridged controls with HIG tokens and themes.

### Candidate bridges

- `HIGCocoaScrollView` for precise scroll control
- `HIGCocoaTextField` for advanced text-input behavior
- `HIGSearchBar` for navigation-integrated search
- `HIGCollectionView` for complex grid layouts
- `HIGVisualEffect` for material-backed surfaces

### API rules

- Public bridging APIs still use `HIG` names.
- Bridged implementations must not expose UIKit or AppKit types publicly.
- Bridging module depends on `HIGPlatform` and theme modules, not on Showcase.

## Requirements

### iOS

- Bridges must use SwiftUI-native APIs only.

### iPadOS

- Same bridging rules as iOS unless AppKit-backed APIs are unavailable.

### macOS

- Bridges may use AppKit representables where needed.

### visionOS

- Bridges are allowed only where platform APIs exist and HIG behavior is preserved.

### tvOS

- Bridges must support focus-friendly navigation and must not assume touch keyboard behavior.

### watchOS

- Bridging is minimal on watchOS; prefer native SwiftUI.

## Out of scope

- UIKit or AppKit application shells
- Exposing raw controller types in public API
- Making bridging a required dependency of `HIGDesignComponents` in the first milestone