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

Run from repository root.

**Preferred one-shot gate** (static guards + unit tests + **iOS and macOS** sample builds):

```bash
Scripts/verify_local_pr.sh
```

Expanded form:

```bash
Scripts/verify_platform_api_guards.sh   # unguarded AppKit/UIKit APIs (fast)
swift test
Scripts/verify_sample_xcode_project.sh  # HIGDesignSample iOS + HIGDesignSampleMac
```

Full multi-SDK package build (slower; use when touching Package.swift / core platform code):

```bash
Scripts/build_all_platforms.sh
```

Showcase snapshot capture is manual — for README and GitHub Pages images only:

```bash
Scripts/capture_showcase_snapshots.sh
```

### Why sample iOS build is required

`swift test` compiles the package for the **host (macOS)**. It will **not** catch Showcase or Sample code that fails only on iOS (classic example: unguarded `Color(nsColor: .windowBackgroundColor)`). Always run `Scripts/verify_sample_xcode_project.sh` (or `verify_local_pr.sh`) after multi-platform UI work.

Individual guards remain available under `Scripts/verify_*.sh` when debugging a single failure.

Showcase design token guard (run when changing Showcase or sample UI):

```bash
Scripts/verify_showcase_token_usage.sh
```

Platform-private API guard (run when touching Showcase / Sample / multi-platform Sources):

```bash
Scripts/verify_platform_api_guards.sh
```

## Agent Workflow

1. Read `AGENTS.md`, `CODING_STANDARDS.md`, and the relevant `Requirements/*/REQ.md`.
2. Check `Docs/UI_DESIGN_GUIDELINES.md` before changing public UI.
3. Update BA docs and architecture docs in the same change when behavior changes.
4. After Showcase / Sample / multi-platform source changes, run `Scripts/verify_local_pr.sh` (or at minimum `verify_platform_api_guards.sh` + `verify_sample_xcode_project.sh`).
5. Do not claim verification passed unless commands were run successfully in the same session.

## Current Milestone

Phase 16 v1.4.0 released. Prefer `Scripts/verify_local_pr.sh` (or platform API guards + sample iOS/macOS builds) before opening a PR. Regenerate showcase PNGs with `Scripts/capture_showcase_snapshots.sh` and `Scripts/capture_ios_showcase_snapshots.sh` when updating README or Pages imagery.

## Xcode

Primary entry point: `Sample/HIGDesignSample.xcodeproj` (iOS + macOS sample app linking local `HIGShowcase`).

```bash
open Sample/HIGDesignSample.xcodeproj
Scripts/verify_sample_xcode_project.sh
```

Package-only entry points (`Package.swift`, `HIGDesign.xcworkspace`) remain for library targets and `HIGSnapshotCapture`.