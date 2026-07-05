#if os(macOS)
import Foundation
import HIGShowcase

/// Device-frame backgrounds bundled with ``HIGSnapshotCapture``.
enum ShowcaseSnapshotBackgrounds {
    static func load(into options: inout ShowcaseSnapshotCaptureOptions) {
        options.deviceBackgrounds = ShowcaseSnapshotDeviceBackgrounds.loadAll()
    }
}
#endif