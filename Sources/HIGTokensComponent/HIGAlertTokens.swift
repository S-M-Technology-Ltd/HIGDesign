import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGAlertTokens: Sendable {
    var cornerRadius: CGFloat { get }
    var contentPadding: CGFloat { get }
    var titleFont: Font { get }
    var messageFont: Font { get }
}

public struct HIGSystemAlertTokens: HIGAlertTokens, Sendable {
    public let cornerRadius: CGFloat
    public let contentPadding: CGFloat
    public let titleFont: Font
    public let messageFont: Font

    public init(
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        contentPadding: CGFloat = HIGSpacing.lg.rawValue,
        titleFont: Font = .headline,
        messageFont: Font = .body
    ) {
        self.cornerRadius = cornerRadius
        self.contentPadding = contentPadding
        self.titleFont = titleFont
        self.messageFont = messageFont
    }
}