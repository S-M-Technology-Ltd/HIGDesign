import CoreGraphics
import HIGTokensRaw

public protocol HIGSpacingSemanticTokens: Sendable {
    var screenEdge: CGFloat { get }
    var section: CGFloat { get }
    var item: CGFloat { get }
    var compactItem: CGFloat { get }
}

public struct HIGSystemSpacingSemanticTokens: HIGSpacingSemanticTokens, Sendable {
    public let screenEdge: CGFloat
    public let section: CGFloat
    public let item: CGFloat
    public let compactItem: CGFloat

    public init(
        screenEdge: CGFloat = HIGSpacing.lg.rawValue,
        section: CGFloat = HIGSpacing.xl.rawValue,
        item: CGFloat = HIGSpacing.md.rawValue,
        compactItem: CGFloat = HIGSpacing.sm.rawValue
    ) {
        self.screenEdge = screenEdge
        self.section = section
        self.item = item
        self.compactItem = compactItem
    }
}