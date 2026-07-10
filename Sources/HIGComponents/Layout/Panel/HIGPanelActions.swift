/// Optional panel header actions (refresh / close). Collapse uses a binding on ``HIGPanel``.
public struct HIGPanelActions {
    /// Invoked when the refresh control is tapped.
    public var onRefresh: (() -> Void)?
    /// Invoked when the close control is tapped.
    public var onClose: (() -> Void)?

    public init(
        onRefresh: (() -> Void)? = nil,
        onClose: (() -> Void)? = nil
    ) {
        self.onRefresh = onRefresh
        self.onClose = onClose
    }
}
