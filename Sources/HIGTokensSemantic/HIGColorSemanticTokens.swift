import SwiftUI

public protocol HIGColorSemanticTokens: Sendable {
    var labelPrimary: Color { get }
    var labelSecondary: Color { get }
    var labelOnAccent: Color { get }
    var backgroundPrimary: Color { get }
    var backgroundSecondary: Color { get }
    var fillPrimary: Color { get }
    var separator: Color { get }
    var accent: Color { get }
    var destructive: Color { get }
    var warning: Color { get }
}

public struct HIGSystemColorSemanticTokens: HIGColorSemanticTokens, Sendable {
    public let labelPrimary: Color
    public let labelSecondary: Color
    public let labelOnAccent: Color
    public let backgroundPrimary: Color
    public let backgroundSecondary: Color
    public let fillPrimary: Color
    public let separator: Color
    public let accent: Color
    public let destructive: Color
    public let warning: Color

    public init(
        labelPrimary: Color? = nil,
        labelSecondary: Color? = nil,
        labelOnAccent: Color? = nil,
        backgroundPrimary: Color? = nil,
        backgroundSecondary: Color? = nil,
        fillPrimary: Color? = nil,
        separator: Color? = nil,
        accent: Color? = nil,
        destructive: Color? = nil,
        warning: Color? = nil
    ) {
        self.labelPrimary = labelPrimary ?? .primary
        self.labelSecondary = labelSecondary ?? .secondary
        self.labelOnAccent = labelOnAccent ?? .white
        self.backgroundPrimary = backgroundPrimary ?? HIGPlatformColor.systemBackground
        self.backgroundSecondary = backgroundSecondary ?? HIGPlatformColor.secondarySystemBackground
        self.fillPrimary = fillPrimary ?? HIGPlatformColor.tertiarySystemFill
        self.separator = separator ?? HIGPlatformColor.separator
        self.accent = accent ?? .accentColor
        self.destructive = destructive ?? .red
        self.warning = warning ?? .orange
    }
}