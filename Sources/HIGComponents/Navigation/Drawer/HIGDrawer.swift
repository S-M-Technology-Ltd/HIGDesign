import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// Themed slide-panel chrome for secondary admin detail panes.
///
/// Inspired by Remark slidepanel. Present with ``View/higDrawer(isPresented:edge:title:content:)``
/// or embed ``HIGDrawer`` for static previews.
public struct HIGDrawer<Content: View>: View {
    private let title: String?
    private let onDismiss: (() -> Void)?
    private let content: () -> Content

    @Environment(\.higTheme) private var theme

    public init(
        title: String? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.onDismiss = onDismiss
        self.content = content
    }

    public var body: some View {
        let tokens = theme.drawer

        VStack(alignment: .leading, spacing: tokens.headerSpacing) {
            if title != nil || onDismiss != nil {
                HStack(alignment: .center, spacing: theme.spacing.item) {
                    if let title {
                        Text(title)
                            .font(tokens.titleFont)
                            .foregroundStyle(theme.colors.labelPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityAddTraits(.isHeader)
                    } else {
                        Spacer(minLength: 0)
                    }

                    if let onDismiss {
                        HIGCloseButton(action: onDismiss)
                    }
                }
            }

            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(tokens.contentPadding)
        .frame(width: tokens.width, alignment: .topLeading)
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(title ?? "Drawer")
    }
}

#if DEBUG
#Preview("HIGDrawer") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGDrawer(title: "Details", onDismiss: {}) {
            Text("Secondary content for the selected row.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}
#endif
