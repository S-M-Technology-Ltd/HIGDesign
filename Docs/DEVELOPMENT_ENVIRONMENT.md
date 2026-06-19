# Development Environment

## Supported Toolchain

- macOS with Xcode 16 or newer
- Swift 6 language mode
- Swift Package Manager

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
```

When package targets exist:

```bash
swift build --package-path .
swift test --package-path .
```

## Agent Workflow

1. Read `AGENTS.md`, `CODING_STANDARDS.md`, and the relevant `Requirements/*/REQ.md`.
2. Check `Docs/UI_DESIGN_GUIDELINES.md` before changing public UI.
3. Update BA docs and architecture docs in the same change when behavior changes.
4. Do not claim verification passed unless commands were run successfully.

## Current Milestone

Governance foundation only. Package build commands become mandatory once `Package.swift` and module targets land.