# Showcase Requirements

## Summary

Demonstration app for visually verifying HIGDesign components, themes, accessibility states, and platform behavior.

## All platforms

### Purpose

- Demonstrate every public component in realistic HIG contexts (including admin surfaces, overlays, `higTooltip`, and `higPopover`).
- Provide theme switcher for light, dark, increased contrast, brand, and optional **Admin** (`HIGAdminTheme`).
- Provide Dynamic Type and Reduce Motion demonstration states.
- Provide an Icon playground in settings when the Icon component is selected (family, token, variant, size, style, and tint). Fixed size uses a slider from the theme small icon token through 512pt.
- Serve as manual QA and DocC companion content.

### Structure

- One showcase target family per platform group where practical:
    * iOS and iPadOS
    * macOS
    * visionOS
    * tvOS
    * watchOS
- Each component screen documents:
    * HIG section reference
    * supported platforms
    * theme dependencies
    * accessibility expectations

### Content rules

- Showcase uses only public HIGDesign APIs.
- Showcase must not become a dependency of library targets.
- Mock data must be deterministic.
- Showcase view code must resolve spacing, padding, colors, typography, corner radius, borders, and opacity from design tokens via `@Environment(\.higTheme)` or approved token helpers (`higPadding`, `HIGSpacing`, `HIGAccessibility`).
- Hardcoded visual literals are not permitted in Showcase sources (for example `spacing: 12`, `.quaternary.opacity(0.35)`, `.font(.headline)`, `cornerRadius: 8`).
- Shared token-backed showcase surfaces should reuse helpers such as `ShowcaseSurfaceTileView`, `ShowcaseSampleView`, and `ShowcaseCodeSnippetView`.
- Every showcase sample renders a monospaced API code snippet directly beneath the live preview.
- Showcase `#Preview` blocks must wrap content in `ShowcasePreviewContainer` (or `HIGThemeableView`) so `@Environment(\.higTheme)` resolves in Xcode previews.

## Requirements

### iOS

- Tab or stack-based navigation is acceptable for phone layouts.

### iPadOS

- Prefer split-view or sidebar navigation for component catalogs.

### macOS

- Use `NavigationSplitView` and resizable windows with useful minimum sizes.

### visionOS

- Demonstrate spatial layout examples only when components are available on visionOS.

### tvOS

- Demonstrate focus navigation paths for TV-appropriate components.

### watchOS

- Demonstrate only compact components intended for watchOS.

## Out of scope

- Production app features
- Remote sample data
- StoreKit or account flows
- Automated screenshot publishing in the first milestone