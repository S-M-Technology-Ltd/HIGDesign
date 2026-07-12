import SwiftUI

/// Corner placement for an overlaid ``HIGRibbon``.
public enum HIGRibbonEdge: Sendable, Equatable {
    case topLeading
    case topTrailing

    /// Alignment used when overlaying a ribbon on a host surface.
    public var alignment: Alignment {
        switch self {
        case .topLeading:
            .topLeading
        case .topTrailing:
            .topTrailing
        }
    }
}
