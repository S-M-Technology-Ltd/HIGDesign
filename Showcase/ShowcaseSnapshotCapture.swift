#if os(macOS)
import AppKit
import Foundation
import HIGDesign
import SwiftUI

@MainActor
public enum ShowcaseSnapshotCapture {
    private static let snapshotSize = CGSize(width: 900, height: 620)

    public static func run() {
        let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let manifestURL = root.appendingPathComponent("Design/Showcase/manifest.json")
        let snapshotRoot = root.appendingPathComponent("Design/Showcase/snapshots")

        guard let manifestData = try? Data(contentsOf: manifestURL),
              let manifest = try? JSONDecoder().decode(Manifest.self, from: manifestData) else {
            fputs("Failed to read showcase snapshot manifest.\n", stderr)
            exit(1)
        }

        try? FileManager.default.createDirectory(at: snapshotRoot, withIntermediateDirectories: true)

        for entry in manifest.entries {
            guard let component = ShowcaseComponent(rawValue: entry.component) else {
                fputs("Unknown showcase component: \(entry.component)\n", stderr)
                exit(1)
            }

            let themeChoice = ShowcaseThemeChoice(rawValue: entry.theme) ?? .system
            let colorScheme: ColorScheme = entry.colorScheme == "dark" ? .dark : .light
            let outputURL = root.appendingPathComponent("Design/Showcase").appendingPathComponent(entry.file)

            let content = ShowcaseSnapshotView(component: component)
                .preferredColorScheme(colorScheme)
                .frame(width: snapshotSize.width, height: snapshotSize.height)

            let wrapped = HIGThemeableView(theme: themeChoice.makeTheme()) {
                content
            }

            guard let pngData = renderPNG(from: wrapped) else {
                fputs("Failed to render \(entry.file)\n", stderr)
                exit(1)
            }

            do {
                try pngData.write(to: outputURL, options: .atomic)
            } catch {
                fputs("Failed to write \(entry.file): \(error)\n", stderr)
                exit(1)
            }
        }

        print("Captured \(manifest.entries.count) showcase snapshots.")
    }

    private static func renderPNG<Content: View>(from content: Content) -> Data? {
        let renderer = ImageRenderer(content: content)
        renderer.scale = 2
        guard let image = renderer.nsImage,
              let tiff = image.tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: tiff),
              let png = bitmap.representation(using: .png, properties: [:]) else {
            return nil
        }
        return png
    }
}

private struct Manifest: Decodable {
    struct Entry: Decodable {
        let component: String
        let theme: String
        let colorScheme: String
        let file: String
    }

    let entries: [Entry]
}
#endif