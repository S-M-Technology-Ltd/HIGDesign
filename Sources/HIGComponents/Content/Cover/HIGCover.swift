import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed cover / banner surface for profile headers and admin marketing blocks.
///
/// Hosts title and optional subtitle over a background (solid style or custom view),
/// with an optional scrim for text contrast. Inspired by Remark Admin covers;
/// chrome resolves from ``HIGTheme/cover``.
public struct HIGCover<Background: View, Actions: View>: View {
    private let title: String
    private let subtitle: String?
    private let showsScrim: Bool
    private let usesOnAccentLabels: Bool
    private let alignment: HorizontalAlignment
    private let background: () -> Background
    private let actions: () -> Actions

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a cover with a custom background view.
    /// - Parameters:
    ///   - title: Primary cover title.
    ///   - subtitle: Optional supporting copy.
    ///   - showsScrim: When `true`, dims the background for label contrast.
    ///   - alignment: Horizontal alignment of title, subtitle, and actions.
    ///   - background: Full-bleed background content (image, gradient, solid).
    ///   - actions: Optional action cluster overlaid on the cover.
    public init(
        _ title: String,
        subtitle: String? = nil,
        showsScrim: Bool = true,
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder background: @escaping () -> Background,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self.title = title
        self.subtitle = subtitle
        self.showsScrim = showsScrim
        self.usesOnAccentLabels = showsScrim
        self.alignment = alignment
        self.background = background
        self.actions = actions
    }

    fileprivate init(
        title: String,
        subtitle: String?,
        showsScrim: Bool,
        usesOnAccentLabels: Bool,
        alignment: HorizontalAlignment,
        background: @escaping () -> Background,
        actions: @escaping () -> Actions
    ) {
        self.title = title
        self.subtitle = subtitle
        self.showsScrim = showsScrim
        self.usesOnAccentLabels = usesOnAccentLabels
        self.alignment = alignment
        self.background = background
        self.actions = actions
    }

    public var body: some View {
        let tokens = theme.cover
        let shape = RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)

        ZStack(alignment: contentAlignment) {
            background()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

            if showsScrim {
                shape
                    .fill(theme.colors.labelPrimary.opacity(tokens.scrimOpacity))
                    .allowsHitTesting(false)
            }

            VStack(alignment: alignment, spacing: tokens.stackSpacing) {
                Text(title)
                    .font(tokens.titleFont)
                    .foregroundStyle(titleColor)
                    .multilineTextAlignment(textAlignment)
                    .frame(maxWidth: .infinity, alignment: frameAlignment)
                    .accessibilityAddTraits(.isHeader)

                if let subtitle {
                    Text(subtitle)
                        .font(tokens.subtitleFont)
                        .foregroundStyle(subtitleColor)
                        .multilineTextAlignment(textAlignment)
                        .frame(maxWidth: .infinity, alignment: frameAlignment)
                }

                if Actions.self != EmptyView.self {
                    VStack(alignment: alignment, spacing: tokens.actionSpacing) {
                        actions()
                    }
                    .frame(maxWidth: .infinity, alignment: frameAlignment)
                }
            }
            .padding(tokens.contentPadding)
        }
        .frame(maxWidth: .infinity, minHeight: tokens.minHeight, alignment: contentAlignment)
        .clipShape(shape)
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabelText)
    }

    private var titleColor: Color {
        usesOnAccentLabels ? theme.colors.labelOnAccent : theme.colors.labelPrimary
    }

    private var subtitleColor: Color {
        if usesOnAccentLabels {
            theme.colors.labelOnAccent.opacity(theme.opacity.labelOnAccentSecondary)
        } else {
            theme.colors.labelSecondary
        }
    }

    private var textAlignment: TextAlignment {
        switch alignment {
        case .center: .center
        case .trailing: .trailing
        default: .leading
        }
    }

    private var frameAlignment: Alignment {
        switch alignment {
        case .center: .center
        case .trailing: .trailing
        default: .leading
        }
    }

    private var contentAlignment: Alignment {
        switch alignment {
        case .center: .center
        case .trailing: .bottomTrailing
        default: .bottomLeading
        }
    }

    private var accessibilityLabelText: String {
        if let subtitle {
            "Cover. \(title). \(subtitle)"
        } else {
            "Cover. \(title)"
        }
    }
}

extension HIGCover where Actions == EmptyView {
    /// Creates a cover without action content.
    public init(
        _ title: String,
        subtitle: String? = nil,
        showsScrim: Bool = true,
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder background: @escaping () -> Background
    ) {
        self.init(
            title,
            subtitle: subtitle,
            showsScrim: showsScrim,
            alignment: alignment,
            background: background,
            actions: { EmptyView() }
        )
    }
}

extension HIGCover where Background == HIGCoverSolidBackgroundView {
    /// Creates a cover with a solid themed fill.
    public init(
        _ title: String,
        subtitle: String? = nil,
        style: HIGCoverStyle = .accent,
        showsScrim: Bool = false,
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        let onAccent = style == .accent
        self.init(
            title: title,
            subtitle: subtitle,
            showsScrim: showsScrim,
            usesOnAccentLabels: onAccent || showsScrim,
            alignment: alignment,
            background: { HIGCoverSolidBackgroundView(style: style) },
            actions: actions
        )
    }
}

extension HIGCover where Background == HIGCoverSolidBackgroundView, Actions == EmptyView {
    /// Creates a solid-fill cover without actions.
    public init(
        _ title: String,
        subtitle: String? = nil,
        style: HIGCoverStyle = .accent,
        showsScrim: Bool = false,
        alignment: HorizontalAlignment = .leading
    ) {
        self.init(
            title,
            subtitle: subtitle,
            style: style,
            showsScrim: showsScrim,
            alignment: alignment,
            actions: { EmptyView() }
        )
    }
}

/// Solid fill used by the themed-style ``HIGCover`` convenience initializers.
public struct HIGCoverSolidBackgroundView: View {
    private let style: HIGCoverStyle

    @Environment(\.higTheme) private var theme

    public init(style: HIGCoverStyle) {
        self.style = style
    }

    public var body: some View {
        switch style {
        case .accent:
            theme.colors.accent
        case .neutral:
            theme.colors.fillPrimary
        }
    }
}

#if DEBUG
#Preview("HIGCover") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: HIGSpacing.lg.rawValue) {
            HIGCover(
                "Product launch",
                subtitle: "Ship admin surfaces that feel native on every Apple platform.",
                style: .accent
            )

            HIGCover(
                "Team workspace",
                subtitle: "Invite teammates and share dashboards.",
                style: .neutral,
                alignment: .center
            ) {
                HIGButton("Invite", role: .secondary) {}
            }
        }
        .padding()
    }
}

#Preview("HIGCoverSolidBackgroundView") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGCoverSolidBackgroundView(style: .accent)
            .frame(height: HIGSpacing.massive.rawValue * 2)
            .clipShape(RoundedRectangle(cornerRadius: HIGRadius.md.rawValue, style: .continuous))
            .padding()
    }
}
#endif
