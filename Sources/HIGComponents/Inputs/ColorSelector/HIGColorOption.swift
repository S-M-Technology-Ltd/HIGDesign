import SwiftUI

/// A selectable color swatch option for ``HIGColorSelector``.
public struct HIGColorOption<Value: Hashable & Sendable>: Identifiable, Sendable {
    public let value: Value
    public let color: Color
    public let label: String

    public var id: Value { value }

    /// Creates a color option.
    /// - Parameters:
    ///   - value: Selection value bound by the selector.
    ///   - color: Swatch fill color.
    ///   - label: Accessibility name for the color (for example `"Blue"`).
    public init(value: Value, color: Color, label: String) {
        self.value = value
        self.color = color
        self.label = label
    }
}
