import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGDatePicker`` and ``HIGTimePicker``.
public protocol HIGDatePickerTokens: Sendable {
    var minHeight: CGFloat { get }
    var font: Font { get }
}

/// System defaults for date and time pickers.
public struct HIGSystemDatePickerTokens: HIGDatePickerTokens, Sendable {
    public let minHeight: CGFloat
    public let font: Font

    public init(
        minHeight: CGFloat = 44,
        font: Font = .body
    ) {
        self.minHeight = minHeight
        self.font = font
    }
}
