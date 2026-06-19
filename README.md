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
swift run HIGShowcase
```

## Status

Phase 4: twelve showcase screens, feedback/navigation APIs (`higAlert`, `HIGToast`, `HIGSidebar`, `higNavigationBarTitle`), and DocC coverage guards (v0.4.0).