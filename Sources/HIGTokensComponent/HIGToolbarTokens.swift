import SwiftUI

public protocol HIGToolbarTokens: Sendable {
    var actionFont: Font { get }
}

public struct HIGSystemToolbarTokens: HIGToolbarTokens, Sendable {
    public let actionFont: Font

    public init(actionFont: Font = .body) {
        self.actionFont = actionFont
    }
}