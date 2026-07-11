/// Semantic role for ``HIGFieldMessage`` under form controls.
public enum HIGFieldMessageKind: String, Sendable, CaseIterable, Equatable {
    case helper
    case error
    case success

    var systemImage: String {
        switch self {
        case .helper: "info.circle"
        case .error: "exclamationmark.circle"
        case .success: "checkmark.circle"
        }
    }
}
