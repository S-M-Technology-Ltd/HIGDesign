# Design Tokens

HIGDesign separates visual decisions into three token layers so components stay consistent and themes stay swappable.

## Layers

| Layer | Module | Purpose |
|-------|--------|---------|
| Raw | `HIGTokensRaw` | Platform-agnostic primitives — spacing steps, radii, durations |
| Semantic | `HIGTokensSemantic` | Meaningful roles — `labelPrimary`, `accent`, `screenEdge`, separator |
| Component | `HIGTokensComponent` | Per-component recipes — `HIGButtonTokens`, `HIGTextFieldTokens` |

## How components consume tokens

Every public `HIG*` view reads ``HIGTheme`` from `@Environment(\.higTheme)` and resolves padding, colors, borders, opacity, and motion from the matching component token struct.

```swift
@Environment(\.higTheme) private var theme

var body: some View {
    let tokens = theme.button
    // use tokens.cornerRadius, tokens.primaryFill, etc.
}
```

## Icon tokens

``HIGIconTokens`` defines base small, medium, and large point sizes. ``HIGIcon`` and ``HIGHeroIcon`` scale these values with Dynamic Type via ``HIGScaledDimension``.

Heroicons identifiers live in ``HIGHeroIconToken`` (``HIGIcons`` module). Resolve outline or solid variants from the active theme:

```swift
HIGHeroIcon(descriptor: theme.outlineIcon(from: .academicCap))
```

## Custom themes

Override semantic colors or individual component token structs when creating ``HIGBrandTheme`` or a bespoke ``HIGTheme`` conformance. See <doc:CustomThemes>.

## Related

- <doc:CustomThemes>
- ``HIGTheme``
- ``HIGSystemTheme``