import SwiftUI

public protocol HIGNavigationBarTokens: Sendable {
    var titleFont: Font { get }
    var actionFont: Font { get }
}

public struct HIGSystemNavigationBarTokens: HIGNavigationBarTokens, Sendable {
    public let titleFont: Font
    public let actionFont: Font

    public init(
        titleFont: Font = .headline,
        actionFont: Font = .body
    ) {
        self.titleFont = titleFont
        self.actionFont = actionFont
    }
}