# Showcase App

HIGDesign includes a runnable showcase for exploring every shipped component before integrating it into your app.

## HIGShowcaseApp (macOS)

```bash
swift run HIGShowcaseApp
```

The showcase provides:

- Sidebar navigation across all 35 components
- Theme picker: system, high contrast, brand
- Light / dark / system appearance
- Dynamic Type size controls
- Reduce Motion preview

## HIGDesignSample (Xcode)

```bash
open Sample/HIGDesignSample.xcodeproj
```

| Scheme | Run destination |
|--------|-----------------|
| `HIGDesignSampleMac` | My Mac |
| `HIGDesignSample` | iPhone or iPad Simulator |

The sample project links the local package and demonstrates production-style integration with `HIGThemeableView`.

## Snapshot gallery

Still images for CI and documentation live in `Design/Showcase/snapshots/`, including device-framed iPhone renders under `platforms/ios/` and macOS window chrome under `platforms/macos/`. The public component gallery is published at [https://promptdora.github.io/HIGDesign/](https://promptdora.github.io/HIGDesign/).

## Related

- <doc:GettingStarted>
- <doc:PlatformSupport>