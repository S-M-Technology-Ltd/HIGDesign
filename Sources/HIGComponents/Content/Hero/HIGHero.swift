import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A prominent hero / jumbotron surface for admin landing and marketing blocks.
///
/// Inspired by Bootstrap/Remark jumbotrons; HIG-native chrome via ``HIGTheme/hero``.
public struct HIGHero<Actions: View>: View {
    private let title: String
    private let subtitle: String?
    private let style: HIGHeroStyle
    private let alignment: HorizontalAlignment
    private let actions: () -> Actions

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a hero surface.
    /// - Parameters:
    ///   - title: Primary headline.
    ///   - subtitle: Optional supporting copy.
    ///   - style: Visual emphasis (standard or accent).
    ///   - alignment: Content alignment within the hero.
    ///   - actions: Optional action cluster (buttons, links).
    public init(
        _ title: String,
        subtitle: String? = nil,
        style: HIGHeroStyle = .standard,
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self.title = title
        self.subtitle = subtitle
        self.style = style
        self.alignment = alignment
        self.actions = actions
    }

    public var body: some View {
        let tokens = theme.hero
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget * 2)

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

            VStack(alignment: alignment, spacing: tokens.actionSpacing) {
                actions()
            }
            .frame(maxWidth: .infinity, alignment: frameAlignment)
        }
        .padding(tokens.contentPadding)
        .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .center)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            if style == .standard {
                RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                    .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabelText)
    }

    private var backgroundColor: Color {
        switch style {
        case .standard:
            theme.colors.backgroundSecondary
        case .accent:
            theme.colors.accent
        }
    }

    private var titleColor: Color {
        switch style {
        case .standard:
            theme.colors.labelPrimary
        case .accent:
            theme.colors.labelOnAccent
        }
    }

    private var subtitleColor: Color {
        switch style {
        case .standard:
            theme.colors.labelSecondary
        case .accent:
            theme.colors.labelOnAccent.opacity(theme.opacity.labelOnAccentSecondary)
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

    private var accessibilityLabelText: String {
        if let subtitle {
            "\(title). \(subtitle)"
        } else {
            title
        }
    }
}

extension HIGHero where Actions == EmptyView {
    /// Creates a hero without action controls.
    public init(
        _ title: String,
        subtitle: String? = nil,
        style: HIGHeroStyle = .standard,
        alignment: HorizontalAlignment = .leading
    ) {
        self.init(
            title,
            subtitle: subtitle,
            style: style,
            alignment: alignment,
            actions: { EmptyView() }
        )
    }
}

#if DEBUG
#Preview("HIGHero") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: HIGSpacing.lg.rawValue) {
            HIGHero(
                "Welcome back",
                subtitle: "Review dashboards, users, and reports.",
                style: .standard
            ) {
                HIGButton("Open dashboard") {}
            }

            HIGHero(
                "Ship faster",
                subtitle: "HIG-native admin components for every platform.",
                style: .accent,
                alignment: .center
            ) {
                HIGButton("Get started") {}
            }
        }
        .padding()
    }
}
#endif
