import Foundation
import HIGShowcase

#if os(macOS)
import AppKit
#endif

@main
@MainActor
enum HIGSnapshotCaptureMain {
    static func main() {
        #if os(macOS)
        let app = NSApplication.shared
        app.setActivationPolicy(.accessory)
        app.activate(ignoringOtherApps: true)

        var options = ShowcaseSnapshotCaptureOptions(
            pilotMode: ProcessInfo.processInfo.environment["HIG_SNAPSHOT_PILOT"] == "1"
        )
        ShowcaseSnapshotBackgrounds.load(into: &options)
        ShowcaseSnapshotCapture.run(options: options)
        #else
        print("Showcase snapshot capture requires macOS.")
        #endif
    }
}