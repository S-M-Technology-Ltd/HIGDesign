/// Horizontal placement for ``HIGChatBubble`` rows.
public enum HIGChatBubbleAlignment: Sendable, Equatable {
    /// Incoming message (peer on the leading edge).
    case leading
    /// Outgoing message (self on the trailing edge).
    case trailing
}
