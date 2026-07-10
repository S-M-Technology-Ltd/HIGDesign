import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// Themed chrome for popover body content.
///
/// Used by ``View/higPopover(isPresented:attachmentAnchor:arrowEdge:content:)`` and
/// available for custom popover presentations.
public struct HIGPopoverContainer<Content: View>: View {
    private let content: () -> Content

    @Environment(\.higTheme) private var theme

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        let tokens = theme.popover

        content()
            .padding(tokens.contentPadding)
            .frame(maxWidth: tokens.maxWidth, alignment: .leading)
            .background(theme.colors.backgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                    .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
            }
            .accessibilityElement(children: .contain)
    }
}

#if DEBUG
#Preview("HIGPopoverContainer") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGPopoverContainer {
            VStack(alignment: .leading, spacing: HIGSpacing.sm.rawValue) {
                Text("Filters")
                    .font(.headline)
                Text("Choose a date range and status.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}
#endif
