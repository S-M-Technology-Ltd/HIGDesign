import Foundation

/// A single segment in a ``HIGBreadcrumb`` trail.
public struct HIGBreadcrumbItem: Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String

    public init(id: String, title: String) {
        self.id = id
        self.title = title
    }

    /// Creates an item using the title as its stable identifier.
    public init(_ title: String) {
        self.id = title
        self.title = title
    }
}
