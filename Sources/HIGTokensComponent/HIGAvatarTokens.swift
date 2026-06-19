import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGAvatarTokens: Sendable {
    var diameter: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemAvatarTokens: HIGAvatarTokens, Sendable {
    public let diameter: CGFloat
    public let font: Font

    public init(diameter: CGFloat = 44, font: Font = .headline) {
        self.diameter = diameter
        self.font = font
    }
}