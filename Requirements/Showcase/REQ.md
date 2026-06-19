# Showcase Requirements

## Summary

Demonstration app for visually verifying HIGDesign components, themes, accessibility states, and platform behavior.

## All platforms

### Purpose

- Demonstrate every public component in realistic HIG contexts.
- Provide theme switcher for light, dark, and increased contrast.
- Provide Dynamic Type and Reduce Motion demonstration states.
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