# ``HIGDesign``

Native SwiftUI design system components, tokens, and themes aligned with Apple Human Interface Guidelines.

@Metadata {
    @DisplayName("HIGDesign")
    @TitleHeading("Framework")
}

## Overview

HIGDesign packages a layered token architecture, environment-driven themes, and reusable `HIG*` components for iOS, iPadOS, macOS, visionOS, tvOS, and watchOS. The library is SwiftUI-only and targets OS releases from the latest three calendar years.

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
- ``HIGComponentPreviewTheme``

### Actions

- ``HIGButton``
- ``HIGButtonRole``
- ``HIGButtonSize``
- ``HIGMenuButton``
- ``HIGMenuButtonPresentation``

### Inputs

- ``HIGTextField``
- ``HIGSecureField``
- ``HIGSearchField``
- ``HIGTextEditor``
- ``HIGPicker``
- ``HIGPhotoPicker``
- ``HIGPhotoPickerConfiguration``
- ``HIGPhotoAsset``
- ``HIGPhotoMediaType``

### Controls

- ``HIGToggle``
- ``HIGCheckbox``
- ``HIGRadio``
- ``HIGRadioOption``
- ``HIGSegmentedControl``
- ``HIGSlider``
- ``HIGStepper``

### Content

- ``HIGLabel``
- ``HIGLabelStyle``
- ``HIGBadge``
- ``HIGBadgeStyle``
- ``HIGTag``
- ``HIGTagStyle``
- ``HIGRemovableTag``
- ``HIGIcon``
- ``HIGIconSize``
- ``HIGIconStyle``
- ``HIGAvatar``
- ``HIGLink``
- ``HIGBulletList``

### Layout

- ``HIGCard``
- ``HIGDivider``
- ``HIGList``
- ``HIGFormSection``

### Navigation

- ``HIGTabBar``
- ``HIGTabItem``
- ``HIGSidebar``
- ``HIGSidebarItem``
- ``HIGNavigationBar``
- ``HIGToolbar``

### Feedback

- ``HIGProgressView``
- ``HIGActivityIndicator``
- ``HIGActivityIndicatorSize``
- ``HIGAlert``
- ``HIGAlertButtonRole``
- ``HIGAlertBanner``
- ``HIGAlertBannerStyle``
- ``HIGToast``
- ``HIGToastQueue``
- ``HIGToastQueueConfiguration``

### Modifiers

- ``higPadding(_:)``
- ``higToolbar(_:)``
- ``HIGToolbarTextAction``
- ``HIGToolbarIconAction``
- ``HIGNavigationBarTextAction``
- ``HIGNavigationBarIconAction``
- ``higAlert(_:isPresented:message:primaryButtonTitle:primaryButtonRole:primaryAction:secondaryButtonTitle:secondaryButtonRole:secondaryAction:)``
- ``higToast(isPresented:message:)``
- ``higToastQueue(_:)``
- ``higNavigationBarTitle(_:displayMode:)``
- ``higNavigationBar(_:displayMode:leading:trailing:)``
- ``HIGNavigationBarDisplayMode``