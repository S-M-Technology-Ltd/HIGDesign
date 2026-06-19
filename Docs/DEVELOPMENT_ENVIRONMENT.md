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
# Same entry point as GitHub Actions PR Checks workflow
Scripts/run_pr_checks.sh

# Or run phases separately:
Scripts/run_governance_checks.sh   # Linux or macOS
Scripts/run_macos_checks.sh        # macOS only (snapshots, builds, sample app)
```

Individual guards remain available under `Scripts/verify_*.sh` when debugging a single failure.

## Agent Workflow

1. Read `AGENTS.md`, `CODING_STANDARDS.md`, and the relevant `Requirements/*/REQ.md`.
2. Check `Docs/UI_DESIGN_GUIDELINES.md` before changing public UI.
3. Update BA docs and architecture docs in the same change when behavior changes.
4. Do not claim verification passed unless commands were run successfully.

## Current Milestone

Phase 13 v1.0.0 preparation. All platform builds, tests, showcase build, coverage guards, DocC coverage, automated snapshot capture (including brand theme variants), and snapshot diff verification are mandatory before merging UI changes.

## Xcode

Primary entry point: `Sample/HIGDesignSample.xcodeproj` (iOS + macOS sample app linking local `HIGShowcase`).

```bash
open Sample/HIGDesignSample.xcodeproj
Scripts/verify_sample_xcode_project.sh
```

Package-only entry points (`Package.swift`, `HIGDesign.xcworkspace`) remain for library targets and `HIGSnapshotCapture`.