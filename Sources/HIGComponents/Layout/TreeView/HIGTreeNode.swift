/// A node in a ``HIGTreeView`` hierarchy.
public struct HIGTreeNode: Identifiable, Hashable, Sendable {
    public let id: String
    public let title: String
    public let systemImage: String?
    public let children: [HIGTreeNode]

    /// Creates a tree node.
    /// - Parameters:
    ///   - id: Stable identifier used for expansion and selection.
    ///   - title: Display title.
    ///   - systemImage: Optional SF Symbol for the row.
    ///   - children: Nested child nodes (empty for leaves).
    public init(
        id: String,
        title: String,
        systemImage: String? = nil,
        children: [HIGTreeNode] = []
    ) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
        self.children = children
    }

    /// Whether this node has no children.
    public var isLeaf: Bool { children.isEmpty }
}
