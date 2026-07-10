import Foundation

/// One entry in a ``HIGTimeline``.
public struct HIGTimelineItem: Identifiable, Hashable, Sendable {
    public let id: String
    public let title: String
    public let detail: String?
    public let timestamp: String?
    public let systemImage: String?

    public init(
        id: String,
        title: String,
        detail: String? = nil,
        timestamp: String? = nil,
        systemImage: String? = nil
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.timestamp = timestamp
        self.systemImage = systemImage
    }

    /// Creates an item using the title as its identifier.
    public init(
        _ title: String,
        detail: String? = nil,
        timestamp: String? = nil,
        systemImage: String? = nil
    ) {
        self.id = title
        self.title = title
        self.detail = detail
        self.timestamp = timestamp
        self.systemImage = systemImage
    }
}
