import HIGThemesContract
import SwiftUI

public enum HIGPaddingAmount: Sendable {
    case screenEdge
    case section
    case item
    case compactItem
}

extension View {
    public func higPadding(_ amount: HIGPaddingAmount) -> some View {
        modifier(HIGPaddingModifier(amount: amount))
    }
}

private struct HIGPaddingModifier: ViewModifier {
    @Environment(\.higTheme) private var theme
    let amount: HIGPaddingAmount

    func body(content: Content) -> some View {
        content.padding(edgeInsets)
    }

    private var edgeInsets: EdgeInsets {
        let value: CGFloat
        switch amount {
        case .screenEdge:
            value = theme.spacing.screenEdge
        case .section:
            value = theme.spacing.section
        case .item:
            value = theme.spacing.item
        case .compactItem:
            value = theme.spacing.compactItem
        }
        return EdgeInsets(top: value, leading: value, bottom: value, trailing: value)
    }
}