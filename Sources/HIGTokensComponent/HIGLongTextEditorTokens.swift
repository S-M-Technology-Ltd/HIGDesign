import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGLongTextEditorTokens: Sendable {
    var minHeight: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var verticalPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var editorFontSize: CGFloat { get }
    var editorLineHeight: CGFloat { get }
    var toolbarHeight: CGFloat { get }
    var toolbarActionSpacing: CGFloat { get }
}

public struct HIGSystemLongTextEditorTokens: HIGLongTextEditorTokens, Sendable {
    public let minHeight: CGFloat
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let editorFontSize: CGFloat
    public let editorLineHeight: CGFloat
    public let toolbarHeight: CGFloat
    public let toolbarActionSpacing: CGFloat

    public init(
        minHeight: CGFloat = 200,
        horizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        verticalPadding: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        editorFontSize: CGFloat = 17,
        editorLineHeight: CGFloat = 1.4,
        toolbarHeight: CGFloat = 44,
        toolbarActionSpacing: CGFloat = HIGSpacing.sm.rawValue
    ) {
        self.minHeight = minHeight
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.editorFontSize = editorFontSize
        self.editorLineHeight = editorLineHeight
        self.toolbarHeight = toolbarHeight
        self.toolbarActionSpacing = toolbarActionSpacing
    }
}