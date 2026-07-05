#if os(iOS)
import Foundation
import SwiftUI

@MainActor
public enum ShowcaseSnapshotIOSCapture {
    public static func run() throws {
        let root = snapshotRepoRoot()
        let showcaseRoot = snapshotOutputRoot(from: root)
        let manifest = try ShowcaseSnapshotManifest.load(from: root)
        let pilotMode = ProcessInfo.processInfo.environment["HIG_SNAPSHOT_PILOT"] == "1"
        let entries = manifest.filtered(pilotMode: pilotMode, mobileOnly: true)
        let deviceBackgrounds = ShowcaseSnapshotDeviceBackgrounds.loadAll()

        for entry in entries {
            guard let component = ShowcaseComponent(rawValue: entry.component) else {
                fputs("Unknown showcase component: \(entry.component)\n", stderr)
                exit(1)
            }

            let themeChoice = ShowcaseThemeChoice(rawValue: entry.theme) ?? .system
            let colorScheme: ColorScheme = entry.colorScheme == "dark" ? .dark : .light
            guard let platform = entry.platform.flatMap(ShowcaseSnapshotPlatform.init(rawValue:)) else {
                continue
            }

            let canvasSize = component.snapshotCanvasSize(for: platform)
            let outputURL = showcaseRoot.appendingPathComponent(entry.file)

            try FileManager.default.createDirectory(
                at: outputURL.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )

            guard let pngData = ShowcaseSnapshotPixelCapture.renderPNG(
                component: component,
                themeChoice: themeChoice,
                colorScheme: colorScheme,
                platform: platform,
                canvasSize: canvasSize,
                deviceBackground: deviceBackgrounds[platform]
            ) else {
                fputs("Failed to render \(entry.file)\n", stderr)
                exit(1)
            }

            try pngData.write(to: outputURL, options: .atomic)
        }

        print("Captured \(entries.count) iOS showcase snapshots.")
    }

    private static func snapshotRepoRoot() -> URL {
        if let override = ProcessInfo.processInfo.environment["HIG_SNAPSHOT_REPO_ROOT"] {
            return URL(fileURLWithPath: override)
        }
        return URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    }

    private static func snapshotOutputRoot(from root: URL) -> URL {
        if let override = ProcessInfo.processInfo.environment["HIG_SNAPSHOT_OUTPUT_ROOT"] {
            return URL(fileURLWithPath: override)
        }
        return root.appendingPathComponent("Design/Showcase")
    }
}
#endif