# HIGDesign

A comprehensive SwiftUI design system that strictly follows Apple Human Interface Guidelines — design tokens, themed components, modifiers, and platform adaptations for iOS, iPadOS, macOS, visionOS, tvOS, and watchOS.

## Documentation

| Area | Location |
|------|----------|
| Product overview | [Docs/PRD.md](Docs/PRD.md) |
| Architecture | [Docs/ARCHITECTURE.md](Docs/ARCHITECTURE.md) |
| BA requirements | [Requirements/](Requirements/README.md) |
| UI guidelines | [Docs/UI_DESIGN_GUIDELINES.md](Docs/UI_DESIGN_GUIDELINES.md) |
| HTML design references | [Design/index.html](Design/index.html) |
| Agent rules | [AGENTS.md](AGENTS.md) |
| Coding standards | [CODING_STANDARDS.md](CODING_STANDARDS.md) |

## Verification

```bash
Scripts/verify_requirements_present.sh
Scripts/verify_ui_guidelines_present.sh
Scripts/verify_xcode_previews_present.sh
Scripts/verify_view_naming.sh
Scripts/verify_no_uikit.sh
swift build --package-path .
swift test --package-path .
Scripts/build_all_platforms.sh
swift run HIGShowcaseApp
```

## Status

Phase 13: HIGPhotoPicker component and sample Xcode project (v0.13.0).

## Open in Xcode

Use the sample app project to browse and run every component:

```bash
open Sample/HIGDesignSample.xcodeproj
# or
Scripts/open_xcode.sh
```

| Scheme | Run on | What you get |
|--------|--------|----------------|
| `HIGDesignSampleMac` | My Mac | Full 32-component showcase catalog |
| `HIGDesignSample` | iPhone / iPad Simulator | Same catalog, touch layouts |

The sample links the local `HIGShowcase` package product. See [Sample/README.md](Sample/README.md).

Package-only workflows (`open Package.swift`, `HIGDesign.xcworkspace`) remain available for library development and `HIGSnapshotCapture`.

