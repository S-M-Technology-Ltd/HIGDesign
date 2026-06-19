# Platform Requirements

## Summary

Platform adapters, capability detection, and layout helpers for all supported Apple platforms.

## All platforms

### Capability model

- Expose `HIGPlatformCapabilities` describing supported features such as pointer, keyboard shortcuts, focus engine, sidebar, tab bar, ornaments, and Digital Crown.
- Components must query capabilities instead of repeating scattered `#if os()` checks.

### Layout helpers

- Provide adaptive stack and readable-width helpers aligned with HIG layout guidance.
- Provide `higMinTouchTarget()` behavior with platform-appropriate defaults.
- Provide `higPlatformAdaptive` composition for idiom-specific view branches.

### Type abstraction

- Platform bridging types follow the `AppKitOrUIKit` abstraction pattern from SwiftUIX.
- Public HIG APIs must not expose raw UIKit or AppKit types.

## Requirements

### iOS

- Default layouts assume phone safe areas and bottom-aligned tab bars where relevant.

### iPadOS

- Support regular width layouts, sidebars, and pointer hover where components expose it.

### macOS

- Support keyboard navigation, focus rings, toolbars, and split views.
- Windows and sheets must have useful minimum sizes when Showcase demonstrates them.

### visionOS

- Support ornament-friendly layout and depth-aware spacing without forcing volumetric assumptions.

### tvOS

- Support focus engine navigation and parallax-friendly component spacing.
- Unavailable patterns must compile out or degrade clearly.

### watchOS

- Support compact stacks and reduced chrome.
- Avoid controls that require precision touch targets unsupported on watch.

## Out of scope

- Non-Apple platforms
- JavaScript or web fallbacks
- App lifecycle or scene management beyond theme injection