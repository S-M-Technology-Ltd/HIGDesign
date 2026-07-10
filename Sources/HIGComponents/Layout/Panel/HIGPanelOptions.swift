/// Non-view configuration for ``HIGPanel`` chrome.
public struct HIGPanelOptions: Sendable, Equatable {
    /// Primary heading shown in the panel header.
    public var title: String?
    /// Secondary supporting text under the title.
    public var description: String?
    /// When `true`, shows a collapse control if a collapse binding is provided.
    public var showsCollapseControl: Bool

    public init(
        title: String? = nil,
        description: String? = nil,
        showsCollapseControl: Bool = false
    ) {
        self.title = title
        self.description = description
        self.showsCollapseControl = showsCollapseControl
    }
}
