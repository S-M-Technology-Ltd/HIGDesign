import SwiftUI

/// Relative size for ``HIGActivityIndicator``.
public enum HIGActivityIndicatorSize: Sendable {
    case small
    case medium
    case large

    var controlSize: ControlSize {
        switch self {
        case .small:
            .small
        case .medium:
            .regular
        case .large:
            .large
        }
    }
}