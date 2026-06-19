CODING STANDARDS - HIGDesign Project

Git Workflow

* Never commit or push directly to `develop` or `main`.
* Create a topic branch from `develop`, push the branch, and open a pull request.
* Keep PRs focused (one feature or fix per PR when practical).
* Ensure CI passes before requesting merge.

Architecture

* HIGDesign must use a layered Swift Package Manager module graph.
* Foundations, Tokens, Themes, Platform, Components, Modifiers, and Bridging must remain separable products.
* No application architecture such as TCA, MVVM business logic, or repository layers belongs in this library unless explicitly requested.
* Business-facing API names use the `HIG` prefix.
* Theme resolution belongs in theme modules and environment values, not inside individual views as one-off constants.
* Platform behavior belongs in `HIGPlatform` or narrowly scoped adapters.

Dependency Setup

* Core library code must remain zero third-party runtime dependencies.
* Do not add remote Swift Package URLs unless explicitly approved.
* Tooling dependencies such as SwiftLint, SwiftFormat, and swift-docc-plugin require explicit approval.
* Do not use CocoaPods or Carthage.
* Reference sibling repositories for patterns only. Do not copy brand-specific code.

Strict Code Rules

* Prefer `struct` over `class`.
* Prefer `enum` for closed sets of design options such as button role, size, and emphasis.
* Do not use underscore to dismiss parameter names unless required by a protocol conformance or Apple API signature.
* Function parameters must not exceed 5. Use a configuration struct if more parameters are needed.
* Prefer `switch` over long `if-else` chains.
* Every non-trivial `enum`, `struct`, `protocol`, `extension`, and `View` should live in its own file.
* No source file may exceed 300 lines of code.
* If any folder has more than 10 files, create logical subfolders.
* Maintain high test coverage for token resolution, theme behavior, and component state logic.
* Do not scatter raw `print` statements through production code.
* Use modern SwiftUI and adaptive layouts for all supported Apple platforms.
* Do not import or call UIKit APIs in package sources or tests. Use SwiftUI environment values and semantic `Color` initializers instead.
* Support only OS releases from the latest three calendar years. Current minimums: iOS 18, iPadOS 18, macOS 15, tvOS 18, watchOS 11, visionOS 2.

Apple HIG UI Standards

* All public components and modifiers must follow Apple Human Interface Guidelines and `Docs/UI_DESIGN_GUIDELINES.md`.
* Native SwiftUI components are the default implementation path.
* Prefer `Button`, `Toggle`, `Picker`, `TextField`, `List`, `Form`, `NavigationStack`, `NavigationSplitView`, `ToolbarItem`, `sheet`, `popover`, and `.searchable` before custom replacements.
* Use system semantic colors and text styles before custom palette values.
* Accessibility is required for all interactive controls.
* Support light mode, dark mode, increased contrast, Dynamic Type, and Reduce Motion.
* Do not create non-native controls without explicit justification and accessibility review.
* macOS surfaces must support keyboard and pointer behavior where practical.
* tvOS surfaces must support focus navigation.
* watchOS surfaces must respect compact layout and minimum legibility.

HIGFoundations Rules

* `HIGFoundations` contains shared utilities, logging, accessibility helpers, idioms, and size classes.
* `HIGFoundations` must not depend on Components, Modifiers, or Bridging.
* Domain-neutral helpers only. No app persistence or networking code.

Token Rules

* Tokens follow Raw, Semantic, and Component layers.
* Raw tokens map to Apple system primitives or documented HIG measurements.
* Semantic tokens are protocol-based and theme-overridable.
* Component tokens belong to one component family only.
* Do not hardcode Orange, custom brand, or web color values in token modules.

Theme Rules

* Apps must inject a theme with `HIGThemeableView`.
* Components read `@Environment(\.higTheme)`.
* Built-in themes must include light, dark, and increased-contrast behavior.
* Theme types must not depend on Showcase or test-only targets.

Component Rules

* Public components use the `HIG` prefix.
* Components must not access networking, persistence, CloudKit, StoreKit, or app-specific services.
* Components must expose accessibility labels, hints, and traits where needed.
* Components must document platform availability when behavior differs.
* New components require tests, DocC docs, a Showcase example, and a same-file `#Preview`.

Platform Rules

* Use `HIGPlatform` capability checks instead of repeated `#if os()` logic.
* iOS and iPadOS are primary targets.
* macOS, visionOS, tvOS, and watchOS may degrade gracefully but must not crash or render unusable controls.
* Do not claim parity where HIG or SwiftUI does not support a pattern on a platform.

Bridging Rules

* Bridging is optional and lives in `HIGBridging`.
* Native SwiftUI is the default.
* Bridged controls must still use HIG tokens for styling.
* Do not leak UIKit or AppKit types through public HIG APIs.
* Bridging must remain SwiftUI-native. UIKit representables are not permitted.

Swift Concurrency Rules

* Use Swift 6 language mode.
* Prefer `Sendable` token structs and enums.
* Mark UI-facing theme APIs with `@MainActor` when needed.
* UI updates must be main-actor safe.
* Do not use GCD or `DispatchQueue`; use Swift concurrency (`Task`, `async`/`await`, actors) instead. Enforced by `Scripts/verify_no_gcd.sh`.

File Organization

* Keep module boundaries aligned with SPM targets.
* Use feature-based folders inside modules:
    * `Actions/`
    * `Controls/`
    * `Inputs/`
    * `Navigation/`
    * `Layout/`
    * `Feedback/`
    * `Content/`
* Do not move files across module boundaries without updating `Docs/ARCHITECTURE.md`.

Requirements Documentation

* When adding requirements, changing requirements, or implementing behavior that changes an existing requirement, update the relevant `Requirements/*/REQ.md` in the same change.
* Keep these docs updated:
    * `Docs/PRD.md`
    * `Docs/ARCHITECTURE.md`
    * `Docs/AGENT_RULES.md`
    * `Requirements/README.md`
* If implementation changes architecture, update `Docs/ARCHITECTURE.md`.
* If implementation changes product behavior or public API guarantees, update `Docs/PRD.md` and the affected `REQ.md`.

Verification

* Do not claim a build or test passed unless the command was actually run successfully.
* Prefer these commands when available:

Scripts/verify_requirements_present.sh

Scripts/verify_ui_guidelines_present.sh

Scripts/verify_xcode_previews_present.sh

Scripts/verify_view_naming.sh

Scripts/verify_no_uikit.sh

swift build --package-path .

swift test --package-path .

Finality

This is the current version of `CODING_STANDARDS.md`.

Do not modify it unless the user explicitly asks for new rules.