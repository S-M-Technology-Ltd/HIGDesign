# Admin Template → HIGDesign Port Tracker

Tracks the full Remark Admin Template capability catalog (`../admin-template`) as HIG-native SwiftUI work. Remark is a **capability checklist**, not a pixel port. Apple HIG remains the visual source of truth.

| Status | Meaning |
|--------|---------|
| **Done** | Public `HIG*` API shipped with tokens, theme, tests, Showcase, docs |
| **In progress** | Active implementation |
| **Planned** | Mapped; not started |
| **Extend** | Existing HIG component needs parity work |
| **Recipe** | Showcase/Sample composition only (no new library module) |
| **Excluded** | Explicitly not shipped; substitute documented |

Reference: `/Users/andy/github/admin-template/design-system/` · demos under `admin-template/classic/base/html/`.

## Wave status

| Wave | Focus | Status |
|------|-------|--------|
| 0 | Inventory, `HIGAdminTheme`, requirements | **Done** |
| 1 | Surfaces & wayfinding (`HIGPanel`, breadcrumbs, steps, …) | **Done** (Wave 1 core surfaces) |
| 2 | Overlays & chrome | **Done** (core overlay kit) |
| 3 | Advanced forms | **Done** (including `HIGDropZone` file upload) |
| 4 | Data display | **In progress** (`HIGDataTable`) |
| 5 | Content hybrids | **In progress** (`HIGCodeBlock`, `HIGCarousel`, `HIGLightbox`, `HIGMediaRow`, `HIGHero`, `HIGListGroup`) |
| 6 | Swift Charts family | **In progress** (`HIGBarChart`, `HIGLineChart`, `HIGPieChart`, `HIGAreaChart`) |
| 7 | Admin shell & layout | **Done** (`HIGAdminShell` styles: sidebar, iconRail, topBar, topIcon, centered, drawer) |
| 8 | Widgets & parity extensions | **In progress** (`HIGCounter`, `HIGWidget`, `HIGPanelGroup`) |
| 9 | App/page Showcase recipes | Planned |
| 10 | Gallery, DocC, release | Planned |

## Themes

| Item | HIG target | Status |
|------|------------|--------|
| Remark primary / skins | `HIGAdminTheme` | **Done** |
| Dense admin spacing | Admin theme spacing overrides | **Done** |
| classic vs material dual tree | One API; token styles only | Excluded (fork) |

## Bootstrap-extend map

| Remark | HIG target | Status |
|--------|------------|--------|
| Alerts | `HIGAlert` / `HIGAlertBanner` | Extend |
| Badge | `HIGBadge` | Extend |
| Breadcrumbs | `HIGBreadcrumb` | **Done** |
| Buttons | `HIGButton` | Extend |
| Button groups | `HIGButtonGroup` | **Done** |
| Card | `HIGCard` | Extend |
| Carousel | `HIGCarousel` | **Done** |

| Code | `HIGCodeBlock` | **Done** |
| Custom forms / forms | Inputs + `HIGFormSection` + `HIGInputGroup` / `HIGFieldMessage` | **Extend** / **Done** (group + messages) |
| Dropdowns | `HIGMenuButton` + menu APIs | Extend |
| Input groups | `HIGInputGroup` | **Done** |
| Grid / utilities | modifiers + docs | Extend |
| Images | `HIGImageFrame` | Planned |

| Jumbotron | `HIGHero` | **Done** |
| List group | `HIGList` / `HIGListGroup` | **Done** (`HIGListGroup` + row; `HIGList` remains native list) |
| Media | `HIGMediaRow` | **Done** |
| Modals | `HIGModal` helpers | **Done** (chrome; native sheet presentation) |
| Close | `HIGCloseButton` | **Done** |
| Navbar | `HIGNavigationBar` + shell | Extend |
| Navs / tabs / accordion | `HIGTabs`, `HIGAccordion` | **Done** |
| Pagination | `HIGPagination` | **Done** |
| Popovers / tooltips | `HIGPopoverContainer`, `HIGTooltipLabel`, `higPopover`, `higTooltip` | **Done** |
| Progress | `HIGProgressView` | Extend |
| Tables | `HIGDataTable` | **Done** (v1 text columns; sorting/selection later) |
| Typography | `HIGLabel` + type tokens | Extend |
| Reboot / glyphicons / font-weight | — | Excluded (web reset / icon fonts) |

## Custom components map

| Remark | HIG target | Status |
|--------|------------|--------|
| Panels | `HIGPanel` | **Done** |
| Page header (structure) | `HIGPageHeader` | **Done** |
| Panel groups | `HIGPanelGroup` | **Done** |
| Avatar | `HIGAvatar` | **Done** (status overlay) |
| Status | `HIGStatusIndicator` | **Done** |
| Steps / pearls | `HIGSteps`, `HIGPearlSteps` | **Done** |
| Timeline | `HIGTimeline` | **Done** |
| Chat / comment | `HIGChatBubble`, `HIGComment` | **Done** |
| Cover / overlay | `HIGCover`, `HIGImageOverlay` | **Done** |
| Pricing | `HIGPricingCard` | **Done** |
| Ribbon / rating / testimonial | `HIGRibbon`, `HIGRating`, `HIGTestimonial` | **Done** |
| Icon / hamburger | `HIGIcon`, `HIGMenuToggle` | **Done** |
| Loader | `HIGActivityIndicator`, `HIGMatrixLoader` | Done |
| Counter / widget | `HIGCounter`, `HIGWidget` | **Done** |
| Divider | `HIGDivider` | Done |
| Checkbox / radio | `HIGCheckbox`, `HIGRadio` | Done |
| Color selector | `HIGColorSelector` | **Done** |
| Social | `HIGSocialButton` | **Done** |
| Animation helpers | motion tokens / modifiers | Extend |
| Example (docs SCSS) | — | Excluded |
| Background / color helpers | Showcase swatches | Recipe |

## Vendor roles (no third-party deps)

| Role | HIG target | Status |
|------|------------|--------|
| Toasts | `HIGToast` | Extend |
| Dialogs | `higConfirmationDialog` / `higAlert` | **Done** |
| Date / time | `HIGDatePicker`, `HIGTimePicker` | **Done** |
| Select / multi / typeahead | `HIGSelect`, `HIGAutocomplete` | **Done** |
| Tags input | `HIGTagInput` | **Done** |
| File upload / drop | `HIGDropZone` | **Done** (browse + drop; security-scoped access owned by caller) |
| Image crop | `HIGPhotoEditor` | Done |
| Tree / sortable | `HIGTreeView`, `HIGReorderableList` | Planned |
| Lightbox / carousel | `HIGLightbox`, `HIGCarousel` | **Done** |
| Top progress (nprogress) | `HIGNetworkProgressBar` | **Done** |
| Button loading (ladda) | `HIGButton` loading | Extend |
| Slide panel | `HIGDrawer` / `higDrawer` | **Done** |
| Calendar | `HIGCalendar` | Planned |
| Charts (all JS libs) | Swift Charts family | **In progress** (`HIGBarChart`, `HIGLineChart`, `HIGPieChart`, `HIGAreaChart`) |
| Maps | MapKit optional / recipe | Planned |
| Dashboard grid | `HIGDashboardGrid` | Planned |
| Video | `HIGVideoPlayer` | Planned |
| Coach marks | `HIGCoachMark` | Planned |
| Icon fonts (15+) | SF Symbols + Heroicons mapping | Excluded (fonts) |
| Animsition | — | Excluded |
| Chart.js / C3 / Flot / … | Swift Charts only | Excluded (vendors) |

## Shells

| Remark shell | HIG target | Status |
|--------------|------------|--------|
| base | `HIGAdminShell` `.sidebar` | **Done** |
| iconbar | `.iconRail` | **Done** |
| topbar | `.topBar` | **Done** |
| topicon | `.topIcon` | **Done** |
| center | `.centered` | **Done** |
| mmenu | `.drawer` | **Done** |

## Widgets / apps / pages

| Category | Approach | Status |
|----------|----------|--------|
| widgets/* | `HIGWidget` + charts/counters recipes | **Partial** (`HIGCounter`, `HIGWidget` done; page recipes planned) |
| apps/* (13) | Showcase recipes only | Planned |
| pages/* (34) | Showcase recipes only | Planned |

## Definition of done (program)

- [ ] Every row above is Done, Recipe, or Excluded
- [x] `HIGAdminTheme` selectable in Showcase
- [x] `HIGPanel` public with full component DoD
- [x] Wave 1 wayfinding surfaces through status/empty state
- [ ] All waves merged via PRs to `develop`
- [ ] No third-party runtime dependencies introduced
