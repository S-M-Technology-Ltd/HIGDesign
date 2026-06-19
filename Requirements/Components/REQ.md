# Components Requirements

## Summary

Public `HIG*` SwiftUI components that implement Apple Human Interface Guidelines using tokens, themes, and platform adapters.

## All platforms

### API conventions

- Public component names use the `HIG` prefix.
- Components read `@Environment(\.higTheme)` and component token providers.
- Components expose role, size, and emphasis enums instead of magic numbers.
- Components must include accessibility labels, hints, traits, and Dynamic Type support.
- Every public `View` component requires a same-file `#Preview`, DocC docs, tests, and a Showcase example.

### Priority component families

#### Actions

- `HIGButton` with roles: primary, secondary, destructive, borderless
- `HIGMenuButton` for menu-triggering actions

#### Controls

- `HIGToggle`
- `HIGCheckbox`
- `HIGRadio`
- `HIGSegmentedControl`
- `HIGSlider`
- `HIGStepper`

#### Inputs

- `HIGTextField`
- `HIGSecureField`
- `HIGSearchField`
- `HIGTextEditor`
- `HIGPicker`

#### Indicators and feedback

- `HIGBadge`
- `HIGTag`
- `HIGProgressView`
- `HIGActivityIndicator`
- `HIGAlert`
- `HIGToast`

#### Layout and navigation

- `HIGCard`
- `HIGDivider`
- `HIGList`
- `HIGNavigationBar`
- `HIGTabBar`
- `HIGSidebar`
- `HIGToolbar`

#### Content

- `HIGLabel`
- `HIGIcon`
- `HIGAvatar`
- `HIGBulletList`
- `HIGLink`

### First delivery milestone

- `HIGButton` is the first end-to-end component and must prove the full token-theme-platform pipeline.

## Requirements

### iOS

- Interactive components use native SwiftUI behavior first.
- Minimum touch targets follow HIG phone guidance unless a component documents an exception.

### iPadOS

- Components adapt to regular width and support pointer hover where HIG recommends it.

### macOS

- Components support keyboard focus, shortcuts where applicable, and desktop-appropriate density.

### visionOS

- Components avoid flat web-style cards when materials and depth are more appropriate.

### tvOS

- Components support focus movement and do not rely on hover or small touch targets.

### watchOS

- Only components appropriate for watch layouts ship on watchOS.
- Unsupported components must be marked unavailable or provide compact alternatives.

## Out of scope

- Application-specific business workflows
- Data persistence inside components
- Cloud sync, StoreKit, or moderation UI
- Brand-specific visual treatments