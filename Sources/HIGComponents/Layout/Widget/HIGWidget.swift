import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A themed dashboard widget surface for hosting counters, charts, or custom content.
///
/// Lighter than ``HIGPanel`` (no collapse/refresh chrome by default). Provide a title,
/// optional subtitle and trailing slot, and a content builder for the body.
/// Inspired by Remark Admin widgets; chrome resolves from ``HIGTheme/widget``.
public struct HIGWidget<Content: View, Trailing: View>: View {
    private let title: String?
    private let subtitle: String?
    private let content: () -> Content
    private let trailing: () -> Trailing

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a dashboard widget.
    /// - Parameters:
    ///   - title: Optional header title.
    ///   - subtitle: Optional secondary header text.
    ///   - content: Widget body (for example ``HIGCounter`` or a chart).
    ///   - trailing: Optional trailing header content (menus, buttons).
    public init(
        _ title: String? = nil,
        subtitle: String? = nil,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.title = title
        self.subtitle = subtitle
        self.content = content
        self.trailing = trailing
    }

    public var body: some View {
        let tokens = theme.widget

        VStack(alignment: .leading, spacing: tokens.stackSpacing) {
            if hasHeader {
                header(tokens: tokens)
            }

            content()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(tokens.contentPadding)
        .frame(maxWidth: .infinity, minHeight: tokens.minHeight, alignment: .topLeading)
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(title ?? "Widget")
    }

    private var hasHeader: Bool {
        title != nil || subtitle != nil || Trailing.self != EmptyView.self
    }

    private func header(tokens: any HIGWidgetTokens) -> some View {
        HStack(alignment: .top, spacing: theme.spacing.item) {
            VStack(alignment: .leading, spacing: tokens.headerSpacing) {
                if let title {
                    Text(title)
                        .font(tokens.titleFont)
                        .foregroundStyle(theme.colors.labelPrimary)
                        .accessibilityAddTraits(.isHeader)
                }
                if let subtitle {
                    Text(subtitle)
                        .font(tokens.subtitleFont)
                        .foregroundStyle(theme.colors.labelSecondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            trailing()
        }
    }
}

extension HIGWidget where Trailing == EmptyView {
    /// Creates a widget without trailing header content.
    public init(
        _ title: String? = nil,
        subtitle: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(title, subtitle: subtitle, content: content, trailing: { EmptyView() })
    }
}

#if DEBUG
#Preview("HIGWidget") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGWidget("Traffic", subtitle: "Last 7 days") {
            HIGCounter(
                "Sessions",
                value: "8,420",
                trend: .up,
                trendLabel: "+6%"
            )
        }
        .padding()
    }
}
#endif
