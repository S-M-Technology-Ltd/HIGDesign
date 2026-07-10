import HIGThemesContract
import SwiftUI

extension View {
    /// Attaches a short helper tooltip using the platform help system where available.
    ///
    /// On macOS and iPadOS pointer hover, SwiftUI ``help(_:)`` presents the system tooltip.
    /// The string is also applied as an accessibility hint for VoiceOver.
    public func higTooltip(_ text: String) -> some View {
        modifier(HIGTooltipModifier(text: text))
    }
}

private struct HIGTooltipModifier: ViewModifier {
    let text: String

    func body(content: Content) -> some View {
        content
            .help(text)
            .accessibilityHint(text)
    }
}
