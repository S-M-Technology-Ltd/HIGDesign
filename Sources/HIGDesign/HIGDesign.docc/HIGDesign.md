# ``HIGDesign``

Native SwiftUI design system components, tokens, and themes aligned with Apple Human Interface Guidelines.

@Metadata {
    @DisplayName("HIGDesign")
    @TitleHeading("Framework")
}

## Overview

HIGDesign packages a layered token architecture, environment-driven themes, and reusable `HIG*` components for iOS, iPadOS, macOS, visionOS, tvOS, and watchOS. The library is SwiftUI-only and targets OS releases from the latest three calendar years.

v1.5.0 adds an optional admin-density theme, admin shell layouts, charts, advanced forms, and Showcase app/page recipes for admin products.

```swift
import HIGDesign

HIGThemeableView(theme: HIGSystemTheme()) {
    HIGButton("Continue", role: .primary) { }
}
```

## Topics

### Getting Started

- <doc:GettingStarted>
- <doc:ShowcaseApp>
- <doc:Components>
- <doc:AdminCatalog>

### Architecture

- <doc:DesignTokens>
- <doc:CustomThemes>
- <doc:PlatformSupport>
- <doc:APIStability>
- <doc:Bridging>

### Theming

- ``HIGTheme``
- ``HIGThemeableView``
- ``HIGSystemTheme``
- ``HIGHighContrastTheme``
- ``HIGBrandTheme``
- ``HIGAdminTheme``
- ``HIGAdminThemeHue``
- ``HIGComponentPreviewTheme``

### Catalog

- <doc:Components>
- <doc:AdminCatalog>
