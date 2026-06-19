# HIGDesign Sample App

`HIGDesignSample.xcodeproj` is the recommended Xcode entry point for browsing and running every HIGDesign component.

## Open

```bash
open Sample/HIGDesignSample.xcodeproj
```

## Schemes

| Scheme | Destination | Purpose |
|--------|-------------|---------|
| `HIGDesignSample` | iPhone / iPad Simulator | Touch-first component inspection |
| `HIGDesignSampleMac` | My Mac | Desktop layout and sidebar navigation |

Both schemes link the local `HIGShowcase` package product, which hosts the full 32-component catalog (`ShowcaseRootView`).

## Package dependency

The sample project references the repository root (`..`) as a local Swift package. Edit components under `Sources/` or `Showcase/`, then rebuild the sample target to see changes.