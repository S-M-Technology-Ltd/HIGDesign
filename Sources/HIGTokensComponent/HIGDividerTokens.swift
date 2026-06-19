import CoreGraphics
import HIGTokensRaw

public protocol HIGDividerTokens: Sendable {
    var thickness: CGFloat { get }
}

public struct HIGSystemDividerTokens: HIGDividerTokens, Sendable {
    public let thickness: CGFloat

    public init(thickness: CGFloat = HIGBorder.hairline.rawValue) {
        self.thickness = thickness
    }
}