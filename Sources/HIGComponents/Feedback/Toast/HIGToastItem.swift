import Foundation

/// A single toast payload for queue presentation.
public struct HIGToastItem: Sendable, Equatable {
    public let message: String
    public let style: HIGToastStyle

    public init(_ message: String, style: HIGToastStyle = .neutral) {
        self.message = message
        self.style = style
    }
}
