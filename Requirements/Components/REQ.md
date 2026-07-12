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

- `HIGButton` with roles: primary, secondary, destructive, borderless; supports `isLoading`
- `HIGButtonGroup` / `HIGButtonGroupAxis` — related action clusters with spacing and optional equal widths; tokens via `theme.buttonGroup`
- `HIGMenuToggle` — hamburger/menu toggle with animated open/closed glyph; tokens via `theme.menuToggle`
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
- `HIGInputGroup` — field chrome with optional leading/trailing adornments; tokens via `theme.inputGroup`
- `HIGFieldMessage` / `HIGFieldMessageKind` — helper, error, and success messages under fields; tokens via `theme.fieldMessage`
- `HIGSecureField`
- `HIGSearchField`
- `HIGTextEditor`
- `HIGPicker`
- `HIGDatePicker` — labeled date selection (date components only); optional range; tokens via `theme.datePicker`
- `HIGTimePicker` — labeled hour-and-minute selection; tokens via `theme.timePicker`
- `HIGSelect` — form select with field chrome for single (`Value?`) or multi (`Set`) selection; tokens via `theme.select`
- `HIGAutocomplete` — typeahead field that filters string suggestions; tokens via `theme.autocomplete`
- `HIGTagInput` — freeform tag chips with type-to-add, optional suggestions, and max-tag cap; tokens via `theme.tagInput`
- `HIGDropZone` — browse/drop file surface with selected-file list; tokens via `theme.dropZone` (iOS, iPadOS, macOS, visionOS)
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
- `HIGCloseButton` — standard dismiss control for modals/sheets/panels; tokens via `theme.closeButton`
- `HIGModal` — themed modal chrome (title, message, close, body, footer) for use inside native sheets; tokens via `theme.modal`
- `HIGTooltipLabel` + `higTooltip(_:)` — themed tooltip label and platform help tooltip; tokens via `theme.tooltip`
- `HIGPopoverContainer` + `higPopover(...)` — themed popover chrome; tokens via `theme.popover`
- `HIGDrawer` / `HIGDrawerEdge` + `higDrawer(...)` — slide-over panel with scrim; tokens via `theme.drawer`
- `higConfirmationDialog(...)` — native confirmation dialog presentation with HIG alert button roles
- `HIGNetworkProgressBar` — thin top progress bar for page/network loading; tokens via `theme.networkProgressBar`

#### Layout and navigation

- `HIGCard`
- `HIGPanel` — admin content surface with optional title, description, refresh/collapse/close actions, body, and footer; tokens via `theme.panel`
- `HIGPanelGroup` — vertical stack of panels/widgets with optional group title; tokens via `theme.panelGroup`
- `HIGRating` — star rating display or interactive selection; tokens via `theme.rating`
- `HIGTestimonial` — customer quote card with author, optional role, avatar, and rating; tokens via `theme.testimonial`
- `HIGRibbon` / `HIGRibbonStyle` / `HIGRibbonEdge` — corner promo ribbon with optional overlay helper; tokens via `theme.ribbon`
- `HIGPricingCard` — pricing plan card with price, feature list, optional CTA, featured emphasis, and ribbon; tokens via `theme.pricingCard`
- `HIGChatBubble` / `HIGChatBubbleAlignment` — incoming or outgoing chat message bubble with optional author, timestamp, and avatar; tokens via `theme.chatBubble`
- `HIGComment` — discussion comment row with author, body, optional timestamp, avatar, reply action, and separator; tokens via `theme.comment`
- `HIGCover` / `HIGCoverStyle` — cover banner with title, optional subtitle, solid or custom background, optional scrim, and actions; tokens via `theme.cover`
- `HIGImageOverlay` / `HIGImageOverlayEdge` — media figure with caption or custom panel overlay and optional scrim; tokens via `theme.imageOverlay`
- `HIGColorSelector` / `HIGColorOption` — circular color swatch selector with bound selection and optional group label; tokens via `theme.colorSelector`
- `HIGSocialButton` / `HIGSocialNetwork` / `HIGSocialButtonStyle` — social/account action buttons with SF Symbols and semantic chrome; tokens via `theme.socialButton`
- `HIGCounter` / `HIGCounterTrend` — dashboard KPI tile with value, caption, optional icon and trend; tokens via `theme.counter`
- `HIGWidget` — dashboard host surface with optional title, subtitle, trailing slot, and body content; tokens via `theme.widget`
- `HIGDataTable` / `HIGDataTableColumn` — columnar admin table with header, striping, horizontal scroll, and empty state; tokens via `theme.dataTable`
- `HIGBreadcrumb` / `HIGBreadcrumbItem` — hierarchical trail; last segment is current; optional `onSelect` for ancestors; tokens via `theme.breadcrumb`
- `HIGPageHeader` — page title with optional subtitle, breadcrumb trail, and trailing actions; tokens via `theme.pageHeader`
- `HIGPagination` — 1-based page navigation with previous/next and numbered pages; tokens via `theme.pagination`
- `HIGTabs` / `HIGTabsItem` — in-content tab labels (not `HIGTabBar`); tokens via `theme.tabs`
- `HIGAccordion` / `HIGAccordionSection` — expandable sections with multi- or single-expand modes; tokens via `theme.accordion`
- `HIGSteps` / `HIGStepsItem` / `HIGStepsAxis` — numbered process trail (horizontal/vertical); tokens via `theme.steps`
- `HIGPearlSteps` — compact pearl/dot step indicator; tokens via `theme.pearlSteps`
- `HIGTimeline` / `HIGTimelineItem` — vertical activity timeline with markers and connectors; tokens via `theme.timeline`
- `HIGStatusIndicator` / `HIGStatusKind` — presence dots (online/away/busy/offline); tokens via `theme.statusIndicator`
- `HIGAvatar` optional `status` overlays a status badge on the avatar
- `HIGEmptyState` — centered empty-content title/message/icon with optional actions; tokens via `theme.emptyState`
- `HIGDivider`
- `HIGList`
- `HIGListGroup` / `HIGListGroupRow` — bordered list-group surface with optional header/footer and selectable rows; tokens via `theme.listGroup`
- `HIGNavigationBar`
- `HIGTabBar`
- `HIGSidebar`
- `HIGAdminShell` / `HIGAdminShellStyle` — admin app shell with brand chrome; `.sidebar`, `.iconRail`, `.topBar`, `.topIcon`, `.centered`, `.drawer`; tokens via `theme.adminShell`
- `HIGToolbar`

#### Admin catalog expansion (planned families)

Full Remark Admin Template parity is tracked in `Docs/ADMIN_TEMPLATE_PORT.md`. Priority follow-ons: Showcase app recipes and remaining planned components (image frame, tree/sortable, calendar, dashboard grid).

#### Content

- `HIGLabel`
- `HIGCodeBlock` — monospaced code surface with optional language label and share; tokens via `theme.codeBlock`
- `HIGCarousel` — paged content carousel with themed indicators and optional auto-advance; tokens via `theme.carousel`
- `HIGLightbox` — full-screen media gallery chrome with counter and previous/next; tokens via `theme.lightbox`
- `HIGMediaRow` — media object row with leading media, title, subtitle, and trailing slot; tokens via `theme.mediaRow`
- `HIGHero` / `HIGHeroStyle` — jumbotron-style hero with title, subtitle, and optional actions; tokens via `theme.hero`
- `HIGIcon`

#### Charts

- `HIGBarChart` / `HIGChartPoint` — vertical bar chart via Apple Swift Charts; tokens via `theme.barChart`
- `HIGLineChart` — line chart for ordered trend series via Apple Swift Charts; tokens via `theme.lineChart`
- `HIGPieChart` / `HIGPieChartStyle` — pie or donut chart for part-to-whole series via Apple Swift Charts; tokens via `theme.pieChart`
- `HIGAreaChart` — filled area chart for ordered trend series via Apple Swift Charts; tokens via `theme.areaChart`
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