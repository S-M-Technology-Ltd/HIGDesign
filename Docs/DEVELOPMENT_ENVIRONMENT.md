# Development Environment

## Supported Toolchain

- macOS with Xcode 16 or newer
- Swift 6 language mode
- Swift Package Manager
- SwiftUI-only package sources (no UIKit)

## Supported OS Releases

Minimum deployment targets cover the latest three calendar years:

- iOS 18 / iPadOS 18
- macOS 15
- tvOS 18
- watchOS 11
- visionOS 2

## Repository Layout

- `AGENTS.md` — primary coding agent instructions
- `CODING_STANDARDS.md` — coding rules
- `Docs/` — product and architecture docs
- `Requirements/` — BA acceptance criteria by module
- `Scripts/` — verification guards

## Local Verification

Run from repository root:

```bash
Scripts/verify_requirements_present.sh
Scripts/verify_ui_guidelines_present.sh
Scripts/verify_xcode_previews_present.sh
Scripts/verify_view_naming.sh
Scripts/verify_no_uikit.sh
Scripts/verify_showcase_coverage.sh
Scripts/verify_docc_coverage.sh
```

```bash
swift build --package-path .
swift test --package-path .
Scripts/build_all_platforms.sh
```

## Agent Workflow

1. Read `AGENTS.md`, `CODING_STANDARDS.md`, and the relevant `Requirements/*/REQ.md`.
2. Check `Docs/UI_DESIGN_GUIDELINES.md` before changing public UI.
3. Update BA docs and architecture docs in the same change when behavior changes.
4. Do not claim verification passed unless commands were run successfully.

## Current Milestone

Phase 4 feedback and navigation. All platform builds, tests, showcase build, showcase coverage, and DocC coverage guards are mandatory before merging UI changes.