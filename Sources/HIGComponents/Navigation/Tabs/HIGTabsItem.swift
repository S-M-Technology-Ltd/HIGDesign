import Foundation

/// A single tab label in ``HIGTabs`` content navigation.
public struct HIGTabsItem: Identifiable, Hashable, Sendable {
    public let id: String
    public let title: String

    public init(id: String, title: String) {
        self.id = id
        self.title = title
    }

    /// Creates a tab item using the title as its identifier.
    public init(_ title: String) {
        self.id = title
        self.title = title
    }
}
