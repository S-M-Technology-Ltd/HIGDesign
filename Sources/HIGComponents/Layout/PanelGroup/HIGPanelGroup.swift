import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A vertical stack of admin panels (or related surfaces) with shared spacing.
///
/// Inspired by Remark Admin **panel-group** containers. Place ``HIGPanel``,
/// ``HIGWidget``, or other dashboard cards as children; spacing resolves from
/// ``HIGTheme/panelGroup``.
public struct HIGPanelGroup<Content: View>: View {
    private let title: String?
    private let content: () -> Content

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a panel group.
    /// - Parameters:
    ///   - title: Optional group heading above the stack.
    ///   - content: Stacked panels or widget children.
    public init(
        _ title: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.content = content
    }

    public var body: some View {
        let tokens = theme.panelGroup

        VStack(alignment: .leading, spacing: tokens.titleSpacing) {
            if let title {
                Text(title)
                    .font(tokens.titleFont)
                    .foregroundStyle(theme.colors.labelPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityAddTraits(.isHeader)
            }

            VStack(alignment: .leading, spacing: tokens.stackSpacing) {
                content()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(title ?? "Panel group")
    }
}

#if DEBUG
#Preview("HIGPanelGroup") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGPanelGroup("Dashboard") {
            HIGPanel("Overview", description: "Weekly summary") {
                Text("Body A")
            }
            HIGPanel("Activity", description: "Recent events") {
                Text("Body B")
            }
        }
        .padding()
    }
}
#endif
