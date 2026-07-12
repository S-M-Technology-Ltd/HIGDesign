HIGDesign Agent Notes

Project Shape

* HIGDesign is an Apple-only SwiftUI design system library that strictly follows Apple Human Interface Guidelines.
* Repository: HIGDesign.
* GitHub: https://github.com/promptdora/HIGDesign
* The library targets all Apple platforms:
    * iOS
    * iPadOS
    * macOS
    * visionOS
    * tvOS
    * watchOS
* The library is built with Apple-native technologies:
    * SwiftUI
    * Swift Package Manager
    * DocC
* Prefer SwiftUI-only APIs in package sources and tests. UIKit or AppKit bridging belongs in `HIGBridging` only when SwiftUI cannot satisfy the requirement.
* Minimum supported OS releases are the latest three calendar years: iOS 18, iPadOS 18, macOS 15, tvOS 18, watchOS 11, visionOS 2.
* HIGDesign is a reusable design system package, not an application shell.
* Do not add a custom backend, web app, React Native, Flutter, Electron, Firebase, Supabase, or cross-platform UI unless explicitly requested.
* Do not add TCA, SwiftData, CloudKit, or StoreKit unless explicitly requested.

Reference Repositories

* Use these sibling repositories as architecture and implementation references only. Do not copy brand-specific code or naming.
* `../ouds-ios` — layered token architecture, theme contract, modular SPM products, accessibility utilities, DocC and snapshot CI.
* `../SwiftUIX` — `AppKitOrUIKit` abstraction, Cocoa bridging for SwiftUI gaps, cross-platform presentation and scroll primitives.
* `../SwiftUI-Design-System-Pro` — token categories, theme engine concepts, component modifier DSL, accessibility helpers.
* `../promptory-apple` — agent file shape, BA requirements layout, coding standards discipline, HIG review process.

Repository Shape

* Keep the Swift Package structure:

HIGDesign/
Package.swift
AGENTS.md
CODING_STANDARDS.md

Docs/
PRD.md
ARCHITECTURE.md
AGENT_RULES.md
DEVELOPMENT_ENVIRONMENT.md
UI_DESIGN_GUIDELINES.md

Requirements/
README.md
Foundation/REQ.md
Tokens/REQ.md
Themes/REQ.md
Platform/REQ.md
Components/REQ.md
Modifiers/REQ.md
Bridging/REQ.md
Showcase/REQ.md

Sources/
HIGFoundations/
HIGTokensRaw/
HIGTokensSemantic/
HIGTokensComponent/
HIGThemesContract/
HIGThemesSystem/
HIGPlatform/
HIGComponents/
HIGModifiers/
HIGBridging/
exported/HIGDesign/

Showcase/
Tests/
Scripts/

* `Sources/HIGFoundations` contains platform utilities, accessibility helpers, logging, and shared types.
* `Sources/HIGTokensRaw` contains Apple system primitives such as spacing, radius, motion, and system color references.
* `Sources/HIGTokensSemantic` contains HIG role-based token protocols.
* `Sources/HIGTokensComponent` contains per-component token protocols.
* `Sources/HIGThemesContract` contains `HIGTheme`, `HIGThemeableView`, and environment keys.
* `Sources/HIGThemesSystem` contains built-in system themes.
* `Sources/HIGPlatform` contains idiom adapters and platform capability detection.
* `Sources/HIGComponents` contains public `HIG*` SwiftUI components.
* `Sources/HIGModifiers` contains cross-cutting view modifiers.
* `Sources/HIGBridging` contains optional Cocoa bridges for SwiftUI gaps.
* `Showcase/` contains per-platform demo apps.
* `Requirements/` contains BA acceptance criteria by module.
* `Docs/` contains product, architecture, and agent policy documents.

Coding Standards

* Follow `CODING_STANDARDS.md`.
* Do not edit `CODING_STANDARDS.md` unless explicitly asked.
* If any instruction conflicts with `CODING_STANDARDS.md`, ask for clarification before changing architecture or coding style.
* Code agent changes must preserve the mandatory modular SPM architecture and HIG-first design policy.

Dependency Rules

* HIGDesign must remain zero third-party runtime dependencies in the core package.
* Optional bridging code may adapt patterns from SwiftUIX, but do not add a remote SwiftUIX dependency unless explicitly approved.
* Do not use CocoaPods or Carthage.
* Test-only and tooling dependencies such as SwiftLint plugins, SwiftFormat, and swift-docc-plugin require explicit approval.
* Do not vendor third-party code into the package without explicit approval and license review.

Architecture Rules

* Use a layered, acyclic module graph:

HIGFoundations
→ HIGTokensRaw
→ HIGTokensSemantic
→ HIGTokensComponent
→ HIGThemesContract
→ HIGThemesSystem / HIGPlatform / HIGBridging
→ HIGComponents / HIGModifiers
→ exported HIGDesign

* Business-facing API names use the `HIG` prefix.
* Public module products must stay separable so consumers can import only tokens, only components, or the umbrella library.
* Theme resolution belongs in `HIGThemesContract` and theme implementations, not in individual components.
* Components must read design values from `@Environment(\.higTheme)` or component token providers.
* All UI dimensions, colors, opacity, padding, width, height, corner radius, and spacing must come from design tokens — never hardcoded literals in component view code.
* Do not hardcode brand colors, custom font families, or non-system spacing inside components.
* Platform differences belong in `HIGPlatform` or component-specific adapters, not scattered `#if os()` blocks.
* Keep PRs small and module-focused.

Git Workflow (required)

* **Never push directly to `develop` or `main`.** All changes land through pull requests.
* Branch from `develop`: `feature/…`, `fix/…`, `chore/…`, or `docs/…`.
* Push your branch and open a PR targeting `develop`.
* Wait for CI (`Build and Test`) to pass before merge.
* Squash-merge or merge via GitHub UI after review. Do not fast-forward push to `develop` from a local checkout.
* Release tags (`v*`) are cut from `develop` only after the release PR is merged.

Swift Concurrency Rules

* Use Swift 6 strict concurrency.
* Prefer `Sendable` token structs and protocol requirements where practical.
* Mark UI-facing theme and environment types with `@MainActor` when they touch SwiftUI state.
* Use `async`/`await` only where side effects exist; token and component rendering should stay synchronous unless bridging requires otherwise.
* Do not use GCD or `DispatchQueue`; use Swift concurrency (`Task`, `async`/`await`, actors) instead. Run `Scripts/verify_no_gcd.sh`.

HIGFoundations Rules

* `HIGFoundations` may import Foundation and SwiftUI only when needed for platform typing.
* Do not import component or theme modules from Foundations.
* Accessibility helpers, size classes, idioms, WCAG utilities, and logging belong here.

Token Rules

* Tokens follow a three-layer model inspired by OUDS:
    * Raw — system primitives
    * Semantic — HIG roles such as label, fill, background, accent
    * Component — per-component sizing, padding, radius, and typography
* Raw tokens must map to Apple system values or documented HIG measurements.
* Semantic tokens must be protocol-based so themes can override them.
* Component tokens must not reach into unrelated component categories.
* Token changes require updates to `Requirements/Tokens/REQ.md` in the same change.

Theme Rules

* Every app integration path starts with `HIGThemeableView`.
* `@Environment(\.higTheme)` is required for themed surfaces.
* Missing theme injection is a programmer error and should fail fast in debug builds.
* Built-in themes must support light mode, dark mode, and increased contrast.
* Theme changes require updates to `Requirements/Themes/REQ.md` in the same change.

Showcase Rules

* Showcase and sample apps demonstrate public HIGDesign APIs only; they must not become dependencies of library targets.
* Showcase view code must resolve spacing, padding, colors, typography, corner radius, borders, and opacity from design tokens — not hardcoded literals such as `spacing: 12`, `.quaternary.opacity(0.35)`, or `.font(.headline)`.
* Read visual values from `@Environment(\.higTheme)` (`theme.spacing`, `theme.colors`, `theme.typography`, `theme.card`, component token structs) or approved helpers such as `higPadding`, `HIGSpacing`, and `HIGAccessibility`.
* Reuse shared showcase helpers such as `ShowcaseSurfaceTileView` for token-backed demo surfaces.
* Showcase changes require updates to `Requirements/Showcase/REQ.md` when behavior or demo affordances change.

Component Rules

* Public components use the `HIG` prefix, for example `HIGButton`, `HIGTextField`, `HIGTabBar`.
* Components must support Dynamic Type, Reduce Motion, Increase Contrast, and VoiceOver.
* Components must declare platform availability explicitly when behavior differs by OS.
* Components must not depend on application state, persistence, networking, or StoreKit.
* New components require:
    * REQ acceptance criteria
    * unit or snapshot tests
    * DocC symbol documentation
    * at least one Showcase example
    * a useful `#Preview` in the component source file

Platform Rules

* iOS and iPadOS are first-class targets.
* macOS must support keyboard, pointer, focus, and toolbar conventions.
* visionOS must respect depth, ornaments, and volumetric layout guidance.
* tvOS must support focus engine navigation and large touch targets.
* watchOS must support compact layouts, Digital Crown interactions where relevant, and minimal chrome.
* Use `HIGPlatform` capability flags instead of duplicating platform checks across components.

Bridging Rules

* Native SwiftUI is the default implementation path.
* Bridging belongs in `HIGBridging` and is optional for package consumers.
* Bridged controls must still resolve colors, typography, spacing, and motion from HIG tokens.
* Prefer not to expose raw UIKit or AppKit types in public HIG component APIs.
* UIKit or AppKit representables and imports are allowed only in `HIGBridging` when SwiftUI cannot satisfy the requirement. Document the justification in the PR.

Requirements Documentation Rules

* When adding requirements, changing requirements, or implementing behavior that changes an existing requirement, update the relevant document in `Requirements/` in the same change.
* Keep these docs current:
    * `Docs/PRD.md`
    * `Docs/ARCHITECTURE.md`
    * `Docs/AGENT_RULES.md`
    * `Requirements/README.md`
    * the affected `Requirements/*/REQ.md`
* If implementation changes architecture, update `Docs/ARCHITECTURE.md`.
* If implementation changes public API or HIG behavior, update `Docs/PRD.md` and the relevant `REQ.md`.

Design Rules

* Apple Human Interface Guidelines are the source of truth for visuals and interaction.
* Check `Docs/UI_DESIGN_GUIDELINES.md` before changing public components or modifiers.
* Prefer system colors, SF Pro text styles, SF Symbols, and native SwiftUI controls.
* Do not introduce custom brand themes unless they are implemented as explicit `HIGTheme` conformances.
* Renderable design references live under `Design/`.
* Start UI work from `Design/hig-design-system.html` or the matching page in `Design/hig/pages/`.

Xcode Preview Rules

* Every public `struct SomeView: View` component must have its own useful, type-named `#Preview` in `SomeView.swift`.
* Preview names must begin with the exact type name, for example `#Preview("HIGButton — Primary")`.
* Previews must use deterministic mock themes and must not depend on live network, file system, or app targets.
* Run `Scripts/verify_xcode_previews_present.sh` for every SwiftUI change.
* Run `Scripts/verify_view_naming.sh` for every SwiftUI change.

Apple HIG UI Rule

* All public components and modifiers must follow Apple Human Interface Guidelines.
* Agents must check `Docs/UI_DESIGN_GUIDELINES.md` before changing UI.
* If changing UI, include a HIG checklist summary in the PR body.
* Do not add cramped controls, non-native layouts, or custom chrome without justification.
* Accessibility is mandatory, not optional.

Logging Rules

* Use `HIGLogger` or the shared logging helper from `HIGFoundations`.
* Do not scatter raw `print` statements through library code.
* Debug logging may describe component name, platform, theme name, and configuration enums.
* Do not log user-entered text, secrets, or private app content.
* Library logging stays local unless remote logging is explicitly requested.

Development Environment Rules

* Target Xcode 16 or newer; CI should verify the latest stable Xcode practical for all six platforms.
* Swift 6 language mode is required.
* Document toolchain changes in `Docs/DEVELOPMENT_ENVIRONMENT.md`.
* Do not claim verification passed unless the relevant command was actually run successfully.
* **`swift test` alone is not enough.** It builds the package for the host (macOS) and will not catch iOS-only sample / Showcase compile failures (for example unguarded `Color(nsColor:)`).
* After any change under `Showcase/`, `Sample/`, or multi-platform `Sources/`, agents **must** run the sample iOS + macOS gate before marking work done:
  * `Scripts/verify_platform_api_guards.sh` (fast static check)
  * `Scripts/verify_sample_xcode_project.sh` (builds `HIGDesignSample` iOS Simulator **and** `HIGDesignSampleMac`)
* Preferred one-shot local PR gate: `Scripts/verify_local_pr.sh` (static guards + `swift test` + sample iOS/macOS builds).
* Never claim “sample builds” or “verification passed” unless those commands were actually executed successfully in this session.

Verification Commands

**Required before opening a PR (or finishing multi-platform UI work):**

```bash
Scripts/verify_local_pr.sh
```

Equivalent expanded form:

```bash
Scripts/verify_platform_api_guards.sh
swift test
Scripts/verify_sample_xcode_project.sh   # iOS Simulator + macOS sample
```

Full package multi-SDK build (slower; run when touching Package.swift or cross-platform core):

```bash
Scripts/build_all_platforms.sh
```

Showcase snapshot capture (`Scripts/capture_showcase_snapshots.sh`) is manual for README/Pages images only.

Individual guards (debugging):

```bash
Scripts/verify_requirements_present.sh
Scripts/verify_ui_guidelines_present.sh
Scripts/verify_xcode_previews_present.sh
Scripts/verify_view_naming.sh
Scripts/verify_component_token_usage.sh
Scripts/verify_showcase_token_usage.sh
Scripts/verify_platform_api_guards.sh
Scripts/verify_photo_picker_token_usage.sh
Scripts/verify_photo_editor_token_usage.sh
Scripts/verify_no_gcd.sh
Scripts/verify_no_uikit.sh
swift build --package-path .
swift test --package-path .
```

Current Milestone

Current milestone: v1.5.0 released (2026-07-12).

v1.5.0 delivered the admin catalog expansion: `HIGAdminTheme`, `HIGAdminShell`, panels/wayfinding, advanced forms, Swift Charts, content hybrids, coach marks, MapKit map recipe, and Wave 9 Showcase app/page recipes. See `Docs/PRD.md` and `CHANGELOG.md`.

Next milestone: optional Extend-row parity polish and platform polish per `Docs/PRD.md` / `Docs/ADMIN_TEMPLATE_PORT.md`.