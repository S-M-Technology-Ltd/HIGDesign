import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A horizontal media object row: leading media, title/subtitle, optional trailing.
///
/// Inspired by Bootstrap/Remark media objects; HIG-native chrome via ``HIGTheme/mediaRow``.
public struct HIGMediaRow<Leading: View, Trailing: View>: View {
    private let title: String
    private let subtitle: String?
    private let showsBorder: Bool
    private let leading: () -> Leading
    private let trailing: () -> Trailing

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a media row.
    /// - Parameters:
    ///   - title: Primary label.
    ///   - subtitle: Optional secondary description.
    ///   - showsBorder: When `true`, draws a subtle bordered surface.
    ///   - leading: Leading media (avatar, icon, thumbnail).
    ///   - trailing: Optional trailing actions or metadata.
    public init(
        _ title: String,
        subtitle: String? = nil,
        showsBorder: Bool = false,
        @ViewBuilder leading: @escaping () -> Leading,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.title = title
        self.subtitle = subtitle
        self.showsBorder = showsBorder
        self.leading = leading
        self.trailing = trailing
    }

    public var body: some View {
        let tokens = theme.mediaRow
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        HStack(alignment: .center, spacing: tokens.spacing) {
            leading()
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
                Text(title)
                    .font(tokens.titleFont)
                    .foregroundStyle(theme.colors.labelPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let subtitle {
                    Text(subtitle)
                        .font(tokens.subtitleFont)
                        .foregroundStyle(theme.colors.labelSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            trailing()
        }
        .padding(.horizontal, tokens.horizontalPadding)
        .padding(.vertical, tokens.verticalPadding)
        .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .leading)
        .background(showsBorder ? theme.colors.backgroundSecondary : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            if showsBorder {
                RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                    .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabelText)
    }

    private var accessibilityLabelText: String {
        if let subtitle {
            "\(title). \(subtitle)"
        } else {
            title
        }
    }
}

extension HIGMediaRow where Trailing == EmptyView {
    /// Creates a media row without trailing content.
    public init(
        _ title: String,
        subtitle: String? = nil,
        showsBorder: Bool = false,
        @ViewBuilder leading: @escaping () -> Leading
    ) {
        self.init(
            title,
            subtitle: subtitle,
            showsBorder: showsBorder,
            leading: leading,
            trailing: { EmptyView() }
        )
    }
}

extension HIGMediaRow where Leading == EmptyView, Trailing == EmptyView {
    /// Creates a text-only media row.
    public init(
        _ title: String,
        subtitle: String? = nil,
        showsBorder: Bool = false
    ) {
        self.init(
            title,
            subtitle: subtitle,
            showsBorder: showsBorder,
            leading: { EmptyView() },
            trailing: { EmptyView() }
        )
    }
}

#if DEBUG
#Preview("HIGMediaRow") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(alignment: .leading, spacing: HIGSpacing.md.rawValue) {
            HIGMediaRow(
                "Alex Rivera",
                subtitle: "Product designer · Online",
                showsBorder: true
            ) {
                HIGAvatar("AR", status: .online)
            } trailing: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }

            HIGMediaRow(
                "Release notes",
                subtitle: "v1.4.0 shipped with matrix loader.",
                showsBorder: true
            ) {
                Image(systemName: "doc.text")
                    .font(.title2)
            }
        }
        .padding()
    }
}
#endif
