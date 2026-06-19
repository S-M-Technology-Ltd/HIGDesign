# Xcode Previews and Mock Data

## Purpose

HIGDesign uses Xcode previews as the primary visual-development surface for SwiftUI components. Every type declared as `struct SomeView: View` must have its own useful, type-named `#Preview` in the same source file.

A preview declared only in a parent or separate file does not satisfy coverage. If a source file declares multiple `View` structs, it must contain a distinct preview for every declared type. Preview names begin with the exact type name, for example `#Preview("HIGButton — Primary")`.

Private implementation helpers still require their own named preview declaration in their declaring file. That dedicated preview may render deterministic parent context that visibly composes the helper when constructing the helper directly would expose implementation-only state.

Run the coverage guard before submitting UI work:

```bash
Scripts/verify_xcode_previews_present.sh
```

## Naming Convention

Public design-system components use the `HIG` prefix:

- `HIGButton`
- `HIGTextField`
- `HIGTabBar`

Internal helper views that are not public API must end with the `View` suffix:

- `ButtonLoadingView`
- `FieldBorderView`

Run the naming guard before submitting UI work:

```bash
Scripts/verify_view_naming.sh
```

## Preview Support

Reusable preview fixtures and mock themes should live beside components or in dedicated preview support folders under:

- `Sources/HIGComponents/`
- `Sources/HIGModifiers/`
- `Showcase/`

Previews must use:

- deterministic mock themes from `HIGThemesSystem`
- safe fictional labels and content
- no live network, file-system, or app-target dependencies

### HIGPhotoPicker

`XCPreviewAgent` does not inherit a host app Info.plist. Photo-picker previews therefore use mock assets and skip PhotoKit when `XCODE_RUNNING_FOR_PREVIEWS=1`.

To exercise the real picker on a device or simulator app, run `HIGDesignSample` (which includes `NSPhotoLibraryUsageDescription`) instead of relying on package-only previews.

## Guard Behavior Before Source Lands

Until SwiftUI source directories exist, `verify_xcode_previews_present.sh` and `verify_view_naming.sh` exit successfully with a skip message. Once `Sources/HIGComponents` or `Showcase/` contains `View` types, the guards become mandatory.