import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A compact corner ribbon label for “NEW”, “SALE”, and similar promo markers.
///
/// Inspired by Remark Admin ribbon badges; metrics resolve from ``HIGTheme/ribbon``.
/// Prefer short uppercase text. Overlay on cards with ``View/higRibbon(_:style:edge:)``.
public struct HIGRibbon: View {
    private let text: String
    private let style: HIGRibbonStyle
    private let edge: HIGRibbonEdge

    @Environment(\.higTheme) private var theme

    /// Creates a corner ribbon label.
    /// - Parameters:
    ///   - text: Short label content (for example `"NEW"` or `"SALE"`).
    ///   - style: Color emphasis.
    ///   - edge: Corner used for shape asymmetry and overlay alignment.
    public init(
        _ text: String,
        style: HIGRibbonStyle = .accent,
        edge: HIGRibbonEdge = .topTrailing
    ) {
        self.text = text
        self.style = style
        self.edge = edge
    }

    public var body: some View {
        let tokens = theme.ribbon

        Text(text)
            .font(tokens.font)
            .foregroundStyle(foregroundColor)
            .lineLimit(1)
            .padding(.horizontal, tokens.horizontalPadding)
            .padding(.vertical, tokens.verticalPadding)
            .background(backgroundColor)
            .clipShape(ribbonShape(cornerRadius: tokens.cornerRadius))
            .accessibilityLabel("Ribbon \(text)")
    }

    private var foregroundColor: Color {
        switch style {
        case .neutral:
            theme.colors.labelPrimary
        case .accent:
            theme.colors.labelOnAccent
        case .destructive:
            theme.colors.destructive
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .neutral:
            theme.colors.fillPrimary
        case .accent:
            theme.colors.accent
        case .destructive:
            theme.colors.destructive.opacity(theme.opacity.subtleFill)
        }
    }

    /// Softens the outer corner toward the host edge while keeping the inner edge readable.
    private func ribbonShape(cornerRadius: CGFloat) -> UnevenRoundedRectangle {
        switch edge {
        case .topLeading:
            UnevenRoundedRectangle(
                topLeadingRadius: cornerRadius,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: cornerRadius,
                topTrailingRadius: cornerRadius,
                style: .continuous
            )
        case .topTrailing:
            UnevenRoundedRectangle(
                topLeadingRadius: cornerRadius,
                bottomLeadingRadius: cornerRadius,
                bottomTrailingRadius: 0,
                topTrailingRadius: cornerRadius,
                style: .continuous
            )
        }
    }
}

extension View {
    /// Overlays a themed ``HIGRibbon`` in the given corner of this view.
    ///
    /// Edge inset resolves from ``HIGTheme/ribbon`` via the ribbon’s environment.
    public func higRibbon(
        _ text: String,
        style: HIGRibbonStyle = .accent,
        edge: HIGRibbonEdge = .topTrailing
    ) -> some View {
        modifier(HIGRibbonOverlayModifier(text: text, style: style, edge: edge))
    }
}

private struct HIGRibbonOverlayModifier: ViewModifier {
    let text: String
    let style: HIGRibbonStyle
    let edge: HIGRibbonEdge

    @Environment(\.higTheme) private var theme

    func body(content: Content) -> some View {
        content.overlay(alignment: edge.alignment) {
            HIGRibbon(text, style: style, edge: edge)
                .padding(theme.ribbon.edgeInset)
                .allowsHitTesting(false)
        }
    }
}

#if DEBUG
#Preview("HIGRibbon") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: HIGSpacing.lg.rawValue) {
            HStack(spacing: HIGSpacing.md.rawValue) {
                HIGRibbon("NEW", style: .accent, edge: .topLeading)
                HIGRibbon("SALE", style: .destructive, edge: .topTrailing)
                HIGRibbon("BETA", style: .neutral)
            }

            Color.clear
                .frame(height: 120)
                .background {
                    RoundedRectangle(cornerRadius: HIGRadius.md.rawValue, style: .continuous)
                        .fill(.quaternary)
                }
                .overlay {
                    Text("Product card")
                }
                .higRibbon("NEW", style: .accent, edge: .topTrailing)
                .clipShape(RoundedRectangle(cornerRadius: HIGRadius.md.rawValue, style: .continuous))
        }
        .padding()
    }
}
#endif
