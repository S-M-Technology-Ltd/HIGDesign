import SwiftUI

public protocol HIGLinkTokens: Sendable {
    var font: Font { get }
}

public struct HIGSystemLinkTokens: HIGLinkTokens, Sendable {
    public let font: Font

    public init(font: Font = .body) {
        self.font = font
    }
}