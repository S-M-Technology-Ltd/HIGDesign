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

## Device signing (local only)

Simulator builds work without extra setup. To run on a physical iPhone or iPad, keep your Apple Development team in a **local** config file that is never committed:

```bash
Scripts/setup_sample_signing.sh
```

Then edit `Sample/Config/Signing.local.xcconfig` and set `DEVELOPMENT_TEAM` to your team ID.

Committed project settings intentionally omit `DEVELOPMENT_TEAM` so personal signing never lands on the remote. If Xcode prompts you to update signing, prefer editing `Signing.local.xcconfig` instead of checking in `project.pbxproj` changes.

## Photo library privacy (iOS)

`HIGPhotoPicker` requires host-app Info.plist entries. The sample iOS target already includes:

- `NSPhotoLibraryUsageDescription`
- `PHPhotoLibraryPreventAutomaticLimitedAccessAlert`

Copy the same keys into your own app target when integrating `HIGPhotoPicker`.