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
Scripts/build_all_platforms.sh
swift test
Scripts/verify_sample_xcode_project.sh

Showcase snapshot capture is manual — for README and GitHub Pages images only:

Scripts/capture_showcase_snapshots.sh
```

Individual guards remain available under `Scripts/verify_*.sh` when debugging a single failure.

Showcase design token guard (run when changing Showcase or sample UI):

Scripts/verify_showcase_token_usage.sh

## Agent Workflow

1. Read `AGENTS.md`, `CODING_STANDARDS.md`, and the relevant `Requirements/*/REQ.md`.
2. Check `Docs/UI_DESIGN_GUIDELINES.md` before changing public UI.
3. Update BA docs and architecture docs in the same change when behavior changes.
4. Do not claim verification passed unless commands were run successfully.

## Current Milestone

Phase 15 v1.3.1 released. Run builds, tests, and individual `Scripts/verify_*.sh` guards locally before opening a PR. Regenerate showcase PNGs with `Scripts/capture_showcase_snapshots.sh` and `Scripts/capture_ios_showcase_snapshots.sh` when updating README or Pages imagery.

## Xcode

Primary entry point: `Sample/HIGDesignSample.xcodeproj` (iOS + macOS sample app linking local `HIGShowcase`).

```bash
open Sample/HIGDesignSample.xcodeproj
Scripts/verify_sample_xcode_project.sh
```

Package-only entry points (`Package.swift`, `HIGDesign.xcworkspace`) remain for library targets and `HIGSnapshotCapture`.