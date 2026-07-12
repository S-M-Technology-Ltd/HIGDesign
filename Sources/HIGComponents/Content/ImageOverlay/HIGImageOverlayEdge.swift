import SwiftUI

/// Placement of the overlay panel within ``HIGImageOverlay``.
public enum HIGImageOverlayEdge: Sendable, Equatable {
    case top
    case bottom
    case center
    case full

    /// Alignment used when positioning the panel over media.
    public var alignment: Alignment {
        switch self {
        case .top:
            .top
        case .bottom:
            .bottom
        case .center:
            .center
        case .full:
            .center
        }
    }
}
