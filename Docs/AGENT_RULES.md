# Agent Rules

These rules apply to automated and human-assisted coding agents working in this repository.

## Product

- HIGDesign is a SwiftUI design system library that follows Apple Human Interface Guidelines.
- The library supports iOS, iPadOS, macOS, visionOS, tvOS, and watchOS.
- HIGDesign is not an application. Do not add app-only concerns such as persistence, sync, purchases, or moderation unless explicitly requested.

## Architecture

- Use modular Swift Package Manager targets with an acyclic dependency graph.
- Keep Foundations, Tokens, Themes, Platform, Components, Modifiers, and Bridging in separate modules.
- Public API names use the `HIG` prefix.
- Theme injection must go through `HIGThemeableView` and `@Environment(\.higTheme)`.
- Components must resolve visual values from tokens and themes, not hardcoded constants.
- Platform-specific behavior belongs in `HIGPlatform` or narrowly scoped adapters.

## Package Boundaries

- `HIGFoundations` contains shared utilities and must not depend on Components or Bridging.
- Token modules must not depend on Components.
- `HIGThemesContract` defines theme protocols and environment keys only.
- `HIGComponents` may depend on Themes, Platform, and Tokens, but not on Showcase or test targets.
- `HIGBridging` is optional and must not become a hard dependency of core components unless explicitly approved.

## Dependency Policy

- Core library code must remain zero third-party runtime dependencies.
- Do not add remote Swift Package dependencies without explicit approval.
- Reference `../ouds-ios`, `../SwiftUIX`, and `../SwiftUI-Design-System-Pro` for patterns only.
- Do not copy Orange brand assets, Orange token values, or unrelated enterprise patterns.

## HIG Policy

- Apple Human Interface Guidelines are the visual and interaction source of truth.
- Check `Docs/UI_DESIGN_GUIDELINES.md` before changing public UI.
- Use system colors, SF Pro text styles, SF Symbols, and native SwiftUI controls by default.
- Every public component must support Dynamic Type, VoiceOver, Reduce Motion, and increased contrast behavior.

## Testing Policy

- Token resolution requires unit tests.
- Public components require snapshot or rendering tests when practical.
- Accessibility labels, traits, and touch-target behavior require tests for interactive components.
- Platform-specific behavior requires at least one test or snapshot per supported platform family when feasible.

## Documentation Policy

- Public API changes require DocC-compatible documentation.
- Behavior changes require updates to the relevant `Requirements/*/REQ.md` in the same change.
- Architecture changes require updates to `Docs/ARCHITECTURE.md`.
- Product scope changes require updates to `Docs/PRD.md`.

## Preview Policy

- Every public `struct SomeView: View` must include a useful `#Preview` in the same file.
- Previews must use deterministic themes and mock data only.

## Logging Policy

- Use the shared HIG logging helper from Foundations.
- Do not use raw `print` for library diagnostics.
- Do not log user-entered text, secrets, or private app content.