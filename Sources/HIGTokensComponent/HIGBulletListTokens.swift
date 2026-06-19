import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGBulletListTokens: Sendable {
    var itemSpacing: CGFloat { get }
    var bulletSpacing: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemBulletListTokens: HIGBulletListTokens, Sendable {
    public let itemSpacing: CGFloat
    public let bulletSpacing: CGFloat
    public let font: Font

    public init(
        itemSpacing: CGFloat = HIGSpacing.sm.rawValue,
        bulletSpacing: CGFloat = HIGSpacing.md.rawValue,
        font: Font = .body
    ) {
        self.itemSpacing = itemSpacing
        self.bulletSpacing = bulletSpacing
        self.font = font
    }
}