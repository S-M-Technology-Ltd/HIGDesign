# Tokens Requirements

## Summary

Three-layer design token system for HIGDesign: Raw, Semantic, and Component tokens.

## All platforms

### Raw tokens

- Raw tokens represent Apple system primitives or documented HIG measurements.
- Categories include color, typography, spacing, radius, border, elevation, opacity, motion, and grid.
- Raw spacing uses a 4pt base grid.
- Raw typography maps to system text styles, not custom font families.
- Raw colors reference semantic system colors or dynamic equivalents.

### Semantic tokens

- Semantic tokens express HIG roles such as `label.primary`, `background.secondary`, `separator`, and `accent`.
- Semantic tokens are protocol-based so themes can override values.
- Semantic color tokens must resolve correctly in light mode, dark mode, and increased contrast.
- Semantic typography tokens must map to Dynamic Type text styles.

### Component tokens

- Component tokens belong to one component family only.
- Examples include button height, field padding, badge radius, and card elevation.
- Component tokens consume semantic tokens; they must not reach into unrelated component families.

### Naming and API

- Public token protocols and enums use the `HIG` prefix.
- Token APIs must be deterministic and side-effect free.
- Token changes require unit tests.

## Requirements

### iOS

- Raw spacing and typography defaults assume phone-first layouts with compact width support.

### iPadOS

- Grid and spacing tokens must support regular width layouts and larger readable widths.

### macOS

- Typography and spacing tokens must support desktop density without breaking Dynamic Type scaling.

### visionOS

- Elevation and materials tokens must be available for depth-aware surfaces.

### tvOS

- Component token defaults must support larger text and focus-friendly dimensions.

### watchOS

- Spacing and typography defaults must support compact watch layouts.

## Out of scope

- Brand-specific token packs beyond system defaults in the first milestone
- Figma import pipelines
- Runtime token editing UI