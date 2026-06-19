import CoreGraphics
import HIGTokensRaw

public protocol HIGBorderSemanticTokens: Sendable {
    var hairline: CGFloat { get }
}

public struct HIGSystemBorderSemanticTokens: HIGBorderSemanticTokens, Sendable {
    public let hairline: CGFloat

    public init(hairline: CGFloat = HIGBorder.hairline.rawValue) {
        self.hairline = hairline
    }
}