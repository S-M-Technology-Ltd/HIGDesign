import Foundation

/// Describes one selectable row in ``HIGSidebar``.
public struct HIGSidebarItem<ID: Hashable & Sendable>: Identifiable, Sendable {
    public let id: ID
    public let title: String
    public let systemImage: String

    public init(id: ID, title: String, systemImage: String) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
    }
}