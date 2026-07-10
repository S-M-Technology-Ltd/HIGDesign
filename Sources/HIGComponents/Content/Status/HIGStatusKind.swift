/// Presence / availability status for ``HIGStatusIndicator`` and ``HIGAvatar``.
public enum HIGStatusKind: String, Sendable, CaseIterable, Equatable {
    case online
    case away
    case busy
    case offline

    /// VoiceOver-friendly label.
    public var accessibilityLabel: String {
        switch self {
        case .online: "Online"
        case .away: "Away"
        case .busy: "Busy"
        case .offline: "Offline"
        }
    }
}
