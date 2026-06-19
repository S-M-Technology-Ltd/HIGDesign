import CoreGraphics
import HIGTokensRaw

public protocol HIGSidebarTokens: Sendable {
    var rowSpacing: CGFloat { get }
    var rowPadding: CGFloat { get }
}

public struct HIGSystemSidebarTokens: HIGSidebarTokens, Sendable {
    public let rowSpacing: CGFloat
    public let rowPadding: CGFloat

    public init(
        rowSpacing: CGFloat = HIGSpacing.xs.rawValue,
        rowPadding: CGFloat = HIGSpacing.sm.rawValue
    ) {
        self.rowSpacing = rowSpacing
        self.rowPadding = rowPadding
    }
}