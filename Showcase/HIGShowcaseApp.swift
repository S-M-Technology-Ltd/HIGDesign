import HIGShowcase
import SwiftUI

@main
struct HIGShowcaseApp: App {
    private var captureSnapshotsOnLaunch: Bool {
        #if os(iOS)
        ProcessInfo.processInfo.environment["HIG_CAPTURE_IOS_SNAPSHOTS"] == "1"
        #else
        false
        #endif
    }

    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            if captureSnapshotsOnLaunch {
                ShowcaseIOSCaptureRunner()
            } else {
                ShowcaseRootView()
            }
            #else
            ShowcaseRootView()
            #endif
        }
        #if os(macOS)
        .defaultSize(width: 1200, height: 800)
        #endif
    }
}

#if os(iOS)
private struct ShowcaseIOSCaptureRunner: View {
    @State private var didStart = false

    var body: some View {
        Color.clear
            .onAppear {
                guard !didStart else { return }
                didStart = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    do {
                        try ShowcaseSnapshotIOSCapture.run()
                        print("Captured iOS showcase snapshots.")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            exit(0)
                        }
                    } catch {
                        fputs("Failed to capture iOS showcase snapshots: \(error)\n", stderr)
                        exit(1)
                    }
                }
            }
    }
}
#endif