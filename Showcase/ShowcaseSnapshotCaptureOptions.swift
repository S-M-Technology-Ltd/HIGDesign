#if os(macOS)
import AppKit
import Foundation

public struct ShowcaseSnapshotCaptureOptions: Sendable {
    public var deviceBackgrounds: [ShowcaseSnapshotPlatform: ShowcaseSnapshotDeviceBackground]
    public var pilotMode: Bool

    public init(
        deviceBackgrounds: [ShowcaseSnapshotPlatform: ShowcaseSnapshotDeviceBackground] = [:],
        pilotMode: Bool = false
    ) {
        self.deviceBackgrounds = deviceBackgrounds
        self.pilotMode = pilotMode
    }
}
#endif