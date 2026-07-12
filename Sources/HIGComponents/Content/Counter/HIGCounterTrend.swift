import Foundation

/// Directional change affordance for ``HIGCounter``.
public enum HIGCounterTrend: String, Sendable, CaseIterable, Equatable {
    /// Positive movement (arrow up).
    case up
    /// Negative movement (arrow down).
    case down
    /// Flat or unspecified movement.
    case neutral

    var systemImage: String {
        switch self {
        case .up: "arrow.up.right"
        case .down: "arrow.down.right"
        case .neutral: "arrow.right"
        }
    }

    var accessibilityLabel: String {
        switch self {
        case .up: "Up"
        case .down: "Down"
        case .neutral: "Unchanged"
        }
    }
}
