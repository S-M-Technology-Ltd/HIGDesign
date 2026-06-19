# ``HIGDesign``

Native SwiftUI design system components, tokens, and themes aligned with Apple Human Interface Guidelines.

## Overview

HIGDesign packages a layered token architecture, environment-driven themes, and reusable `HIG*` components for iOS, iPadOS, macOS, visionOS, tvOS, and watchOS. The library is SwiftUI-only and targets OS releases from the latest three calendar years.

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:Components>

### Theming

- ``HIGTheme``
- ``HIGThemeableView``
- ``HIGSystemTheme``
- ``HIGHighContrastTheme``
- ``HIGComponentPreviewTheme``

### Components

- ``HIGButton``
- ``HIGButtonRole``
- ``HIGButtonSize``
- ``HIGTextField``
- ``HIGToggle``
- ``HIGDivider``
- ``HIGProgressView``
- ``HIGCard``
- ``HIGTabBar``
- ``HIGTabItem``
- ``HIGToast``
- ``HIGSidebar``
- ``HIGSidebarItem``
- ``HIGAlertButtonRole``

### Modifiers

- ``higPadding(_:)``
- ``higToolbar(_:)``
- ``HIGToolbarTextAction``
- ``higAlert(_:isPresented:message:primaryButtonTitle:primaryButtonRole:primaryAction:secondaryButtonTitle:secondaryButtonRole:secondaryAction:)``
- ``higToast(isPresented:message:)``
- ``higNavigationBarTitle(_:displayMode:)``
- ``HIGNavigationBarDisplayMode``