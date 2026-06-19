# Foundation Requirements

## Summary

Cross-cutting utilities that every HIGDesign module depends on: platform idioms, size classes, accessibility helpers, logging, and shared types.

## All platforms

### Platform identification

- Expose `HIGUserInterfaceIdiom` covering iOS, iPadOS, macOS, visionOS, tvOS, and watchOS.
- Expose horizontal and vertical size class environment values compatible with HIG layout guidance.
- Support an `extraCompact` width class for very small phones when HIG spacing needs tighter treatment.

### Accessibility

- Expose helpers for Reduce Motion, Increase Contrast, Bold Text, and Dynamic Type size.
- Provide WCAG contrast checking utilities for semantic color pairs.
- Define minimum touch-target helpers used by interactive components.

### Logging

- Provide `HIGLogger` for debug diagnostics.
- Logs may include module name, component name, theme name, platform, and enum configuration.
- Logs must not include user-entered text, secrets, or private app content.
- Do not use raw `print` in production library code.

### Shared types

- Shared measurement, edge inset, and identifier helpers must be `Sendable` when practical.
- Foundations must not depend on Components, Modifiers, or Bridging.

## Requirements

### iOS

- Size class values derive from SwiftUI environment and screen width.
- Touch-target helpers default to 44pt minimum interactive height where HIG requires it.

### iPadOS

- Support regular horizontal size class behavior for split layouts and sidebars.
- Pointer hover is not required in Foundations, but size classes must not assume phone-only widths.

### macOS

- Expose keyboard- and pointer-relevant capability flags for downstream components.
- Minimum click-target helpers may use macOS-appropriate values when HIG differs from iOS.

### visionOS

- Expose capability flags for ornaments, depth, and volumetric layout without hardcoding scene assumptions.

### tvOS

- Expose focus-engine capability flags and large-target defaults for downstream components.

### watchOS

- Expose compact-layout capability flags and smaller minimum target defaults where HIG allows.

## Out of scope

- Theme definitions
- Public visual components
- Cocoa bridging
- Application persistence or networking