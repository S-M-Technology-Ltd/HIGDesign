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
- `HIGPhotoPicker`
- `HIGPhotoEditor`
- `HIGLongTextEditor`

#### Indicators and feedback

- `HIGBadge`
- `HIGTag`
- `HIGProgressView`
- `HIGActivityIndicator` with styles: `system` (default), `orbital`, `pulsing`, `arcs`, `rotatingDots`, `flickeringDots`, `scalingDots`, `opacityDots`, `equalizer`, `growingCircle`, `gradient`
- `HIGMatrixLoader` with **112** clean-room catalog entries via `HIGMatrixLoaderID` (23 square, 20 circular, 10 hex, 20 3×3, 20 triangle, 18 fun, 1 icon); convenience `HIGMatrixLoaderStyle` aliases; sizes `small` / `medium` / `large`; deterministic `seed` selection across the full catalog; Reduce Motion static poses
- `HIGAlert`
- `HIGToast`

#### Layout and navigation

- `HIGCard`
- `HIGPanel` — admin content surface with optional title, description, refresh/collapse/close actions, body, and footer; tokens via `theme.panel`
- `HIGBreadcrumb` / `HIGBreadcrumbItem` — hierarchical trail; last segment is current; optional `onSelect` for ancestors; tokens via `theme.breadcrumb`
- `HIGPageHeader` — page title with optional subtitle, breadcrumb trail, and trailing actions; tokens via `theme.pageHeader`
- `HIGPagination` — 1-based page navigation with previous/next and numbered pages; tokens via `theme.pagination`
- `HIGTabs` / `HIGTabsItem` — in-content tab labels (not `HIGTabBar`); tokens via `theme.tabs`
- `HIGAccordion` / `HIGAccordionSection` — expandable sections with multi- or single-expand modes; tokens via `theme.accordion`
- `HIGSteps` / `HIGStepsItem` / `HIGStepsAxis` — numbered process trail (horizontal/vertical); tokens via `theme.steps`
- `HIGPearlSteps` — compact pearl/dot step indicator; tokens via `theme.pearlSteps`
- `HIGDivider`
- `HIGList`
- `HIGNavigationBar`
- `HIGTabBar`
- `HIGSidebar`
- `HIGToolbar`

#### Admin catalog expansion (planned families)

Full Remark Admin Template parity is tracked in `Docs/ADMIN_TEMPLATE_PORT.md`. Priority follow-ons after steps/pearls: timeline, status indicator, empty state, data table, form advanced inputs, Swift Charts, and `HIGAdminShell`.

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