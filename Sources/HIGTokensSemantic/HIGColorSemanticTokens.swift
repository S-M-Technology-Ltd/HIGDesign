import SwiftUI

public protocol HIGColorSemanticTokens: Sendable {
    var labelPrimary: Color { get }
    var labelSecondary: Color { get }
    var backgroundPrimary: Color { get }
    var backgroundSecondary: Color { get }
    var fillPrimary: Color { get }
    var separator: Color { get }
    var accent: Color { get }
    var destructive: Color { get }
}

public struct HIGSystemColorSemanticTokens: HIGColorSemanticTokens, Sendable {
    public let labelPrimary: Color
    public let labelSecondary: Color
    public let backgroundPrimary: Color
    public let backgroundSecondary: Color
    public let fillPrimary: Color
    public let separator: Color
    public let accent: Color
    public let destructive: Color

    public init(
        labelPrimary: Color? = nil,
        labelSecondary: Color? = nil,
        backgroundPrimary: Color? = nil,
        backgroundSecondary: Color? = nil,
        fillPrimary: Color? = nil,
        separator: Color? = nil,
        accent: Color? = nil,
        destructive: Color? = nil
    ) {
        self.labelPrimary = labelPrimary ?? .primary
        self.labelSecondary = labelSecondary ?? .secondary
        self.backgroundPrimary = backgroundPrimary ?? HIGPlatformColor.systemBackground
        self.backgroundSecondary = backgroundSecondary ?? HIGPlatformColor.secondarySystemBackground
        self.fillPrimary = fillPrimary ?? HIGPlatformColor.tertiarySystemFill
        self.separator = separator ?? HIGPlatformColor.separator
        self.accent = accent ?? .accentColor
        self.destructive = destructive ?? .red
    }
}