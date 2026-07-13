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

Both schemes link the local `HIGShowcase` package product (`ShowcaseRootView`):

- **Components** tab — library component demos (A–Z)
- **Pages** tab — full-screen app and page recipes (login, mailbox, dashboard-style apps, …)

Use the theme control (including **Admin**) in the sidebar settings footer.

## Package dependency

The sample project references the repository root (`..`) as a local Swift package. Edit components under `Sources/` or `Showcase/`, then rebuild the sample target to see changes.

## Device signing (local only)

Simulator builds work without extra setup. To run on a physical iPhone or iPad, keep your Apple Development team in a **local** config file that is never committed:

```bash
Scripts/setup_sample_signing.sh
```

Then edit `Sample/Config/Signing.local.xcconfig` and set `DEVELOPMENT_TEAM` to your team ID.

Committed project settings intentionally omit `DEVELOPMENT_TEAM` so personal signing never lands on the remote. If Xcode prompts you to update signing, prefer editing `Signing.local.xcconfig` instead of checking in `project.pbxproj` changes.

## Photo components (iOS)

`HIGPhotoPicker` and `HIGPhotoEditor` appear in the component sidebar (after **Photo Picker**). Select **Photo Editor** and tap **Edit Photo** to open the crop UI.

- **iOS Simulator / device** — full interactive demo for both components.
- **macOS sample** — sidebar entry is present; the detail pane explains that photo components are iOS-only.

Rebuild the sample target after pulling changes (`Product → Clean Build Folder`, then Run). The catalog is driven by `ShowcaseComponent.allCases` in the local package — there is no separate sample-only component list.

### Photo library privacy

`HIGPhotoPicker` requires host-app Info.plist entries. The sample iOS target sets `INFOPLIST_FILE` to `HIGDesignSample/Info.plist`, which includes:

- `NSPhotoLibraryUsageDescription`
- `PHPhotoLibraryPreventAutomaticLimitedAccessAlert` (`true`)

Copy the same keys into your own app target when integrating `HIGPhotoPicker`. The boolean limited-access key must live in a real Info.plist — `INFOPLIST_KEY_*` build settings alone may not embed it.

For Xcode Previews of photo-picker UI, prefer opening `HIGDesignSample` so the preview host includes these privacy keys. Package-only previews use mock PhotoKit data and do not replace a signed app run on device.