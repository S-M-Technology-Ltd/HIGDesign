/// A row model for ``HIGReorderableList``.
public struct HIGReorderableListItem: Identifiable, Hashable, Sendable {
    public let id: String
    public var title: String
    public var systemImage: String?

    /// Creates a reorderable list item.
    /// - Parameters:
    ///   - id: Stable identity used during reordering.
    ///   - title: Primary row title.
    ///   - systemImage: Optional SF Symbol.
    public init(id: String, title: String, systemImage: String? = nil) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
    }
}
