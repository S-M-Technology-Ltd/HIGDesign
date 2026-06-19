# HIGDesign Requirements

Business and product requirements are organized by library module. Each module has a `REQ.md` with platform-specific sections when behavior differs.

## Core modules

| Module | Document |
|--------|----------|
| Foundations (utilities, a11y, logging, idioms) | [Foundation/REQ.md](Foundation/REQ.md) |
| Design tokens (raw, semantic, component) | [Tokens/REQ.md](Tokens/REQ.md) |
| Theme contract and system themes | [Themes/REQ.md](Themes/REQ.md) |
| Platform adapters and capabilities | [Platform/REQ.md](Platform/REQ.md) |
| Public `HIG*` components | [Components/REQ.md](Components/REQ.md) |
| Cross-cutting view modifiers | [Modifiers/REQ.md](Modifiers/REQ.md) |
| Optional Cocoa bridging | [Bridging/REQ.md](Bridging/REQ.md) |
| Showcase and documentation app | [Showcase/REQ.md](Showcase/REQ.md) |

## Platform section convention

Each `REQ.md` uses:

- `### iOS` — iPhone-specific behavior
- `### iPadOS` — iPad-specific behavior when it differs from iPhone
- `### macOS` — Mac-specific behavior
- `### visionOS` — visionOS-specific behavior
- `### tvOS` — Apple TV-specific behavior
- `### watchOS` — Apple Watch-specific behavior

When all platforms share the same rule, it appears under **All platforms** with no per-OS split.

## Related documents

Technical architecture, development environment, UI guidelines, and agent rules remain in [`Docs/`](../Docs/).