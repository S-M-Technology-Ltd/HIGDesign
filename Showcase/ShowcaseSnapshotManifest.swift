import Foundation

public struct ShowcaseSnapshotManifest: Decodable, Sendable {
    public struct Entry: Decodable, Sendable {
        public let kind: String
        public let component: String
        public let theme: String
        public let colorScheme: String
        public let file: String
        public let platform: String?
    }

    public let entries: [Entry]

    public static func load(from root: URL) throws -> ShowcaseSnapshotManifest {
        let manifestURL = root.appendingPathComponent("Design/Showcase/manifest.json")
        let data = try Data(contentsOf: manifestURL)
        return try JSONDecoder().decode(ShowcaseSnapshotManifest.self, from: data)
    }

    public func filtered(
        pilotMode: Bool,
        mobileOnly: Bool = false,
        desktopOnly: Bool = false
    ) -> [Entry] {
        entries.filter { entry in
            if pilotMode && !matchesPilot(entry) { return false }
            if mobileOnly && !isMobilePlatformEntry(entry) { return false }
            if desktopOnly && isMobilePlatformEntry(entry) { return false }
            return true
        }
    }

    private func matchesPilot(_ entry: Entry) -> Bool {
        entry.kind == "platform"
            && entry.component == ShowcaseComponent.button.rawValue
            && (entry.platform == ShowcaseSnapshotPlatform.ios.rawValue
                || entry.platform == ShowcaseSnapshotPlatform.macos.rawValue)
    }

    public func isMobilePlatformEntry(_ entry: Entry) -> Bool {
        guard entry.kind == "platform", let platform = entry.platform else { return false }
        return platform == ShowcaseSnapshotPlatform.ios.rawValue
            || platform == ShowcaseSnapshotPlatform.ipados.rawValue
    }
}