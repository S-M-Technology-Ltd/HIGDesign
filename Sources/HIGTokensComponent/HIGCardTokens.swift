import CoreGraphics
import HIGTokensRaw

public protocol HIGCardTokens: Sendable {
    var cornerRadius: CGFloat { get }
    var contentPadding: CGFloat { get }
    var borderWidth: CGFloat { get }
}

public struct HIGSystemCardTokens: HIGCardTokens, Sendable {
    public let cornerRadius: CGFloat
    public let contentPadding: CGFloat
    public let borderWidth: CGFloat

    public init(
        cornerRadius: CGFloat = HIGRadius.lg.rawValue,
        contentPadding: CGFloat = HIGSpacing.lg.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue
    ) {
        self.cornerRadius = cornerRadius
        self.contentPadding = contentPadding
        self.borderWidth = borderWidth
    }
}