import CoreGraphics
import HIGTokensComponent

/// Relative size for ``HIGMatrixLoader``.
public enum HIGMatrixLoaderSize: String, CaseIterable, Sendable, Hashable {
    case small
    case medium
    case large

    func diameter(for tokens: any HIGMatrixLoaderTokens) -> CGFloat {
        switch self {
        case .small:
            tokens.smallDiameter
        case .medium:
            tokens.mediumDiameter
        case .large:
            tokens.largeDiameter
        }
    }
}
