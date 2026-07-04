#if os(iOS)
import Foundation

enum HIGPhotoPickerRuntime {
    /// `true` when SwiftUI previews are executing inside `XCPreviewAgent`.
    static var isRunningInXcodePreview: Bool {
        #if DEBUG
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        #else
        false
        #endif
    }

    static var shouldAccessPhotoKit: Bool {
        !isRunningInXcodePreview
    }

    /// Debug marker to confirm the serial-queue image pipeline is linked (not the removed `PhotoKitCoordinator` actor).
    static let imagePipelineIdentifier = "HIGPhotoPicker.ImageLoadingClient.v2"
}
#endif