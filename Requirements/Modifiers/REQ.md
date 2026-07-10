# Modifiers Requirements

## Summary

Cross-cutting SwiftUI view modifiers that apply HIG tokens and accessibility behavior consistently.

## All platforms

### Modifier families

- Typography: `higFont`, heading and body helpers
- Color: `higForegroundStyle`, `higBackgroundStyle`
- Layout: `higPadding`, `higCornerRadius`, `higReadableContentWidth`
- Elevation: `higElevation`, `higShadow`
- Accessibility: `higAccessibilityLabel`, `higAccessibilityHint`, `higAccessibilityHidden`
- Motion: `higAnimation`, `higReduceMotionAware`
- Loading placeholders: `higShimmer` with mask, overlay, and background modes
- Tooltips: `higTooltip(_:)` (platform help + accessibility hint)
- Popovers: `higPopover(isPresented:attachmentAnchor:arrowEdge:content:)` wrapping themed ``HIGPopoverContainer`` chrome

### Behavior

- Modifiers must resolve values from the active theme when they represent design tokens.
- Modifiers must not introduce business logic or side effects.
- Modifiers must compose safely with native SwiftUI modifiers.
- Public modifiers require DocC docs and unit tests for token resolution.

## Requirements

### iOS

- Padding and readable-width modifiers assume phone safe areas by default.

### iPadOS

- Readable-width modifiers support wider content columns on regular size class.

### macOS

- Modifiers must not break keyboard focus visibility.

### visionOS

- Elevation and material modifiers must remain usable in spatial layouts.

### tvOS

- Motion modifiers must respect Reduce Motion and focus-friendly timing.

### watchOS

- Padding and typography modifiers must remain legible in compact layouts.

## Out of scope

- Application navigation modifiers
- Networking or persistence side effects
- Custom animation engines unrelated to HIG motion guidance