import CoreGraphics
import HIGTokensRaw

public protocol HIGListTokens: Sendable {
    var rowSpacing: CGFloat { get }
    var sectionSpacing: CGFloat { get }
}

public struct HIGSystemListTokens: HIGListTokens, Sendable {
    public let rowSpacing: CGFloat
    public let sectionSpacing: CGFloat

    public init(
        rowSpacing: CGFloat = HIGSpacing.sm.rawValue,
        sectionSpacing: CGFloat = HIGSpacing.lg.rawValue
    ) {
        self.rowSpacing = rowSpacing
        self.sectionSpacing = sectionSpacing
    }
}