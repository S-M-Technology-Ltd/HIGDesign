import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed media figure with an overlaid caption or panel.
///
/// Inspired by Remark Admin image overlays; chrome resolves from ``HIGTheme/imageOverlay``.
/// Prefer short titles. Use a custom panel builder for icons or action rows.
public struct HIGImageOverlay<Media: View, Panel: View>: View {
    private let edge: HIGImageOverlayEdge
    private let showsScrim: Bool
    private let media: () -> Media
    private let panel: () -> Panel

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates an image overlay with custom media and panel content.
    /// - Parameters:
    ///   - edge: Where the panel sits over the media.
    ///   - showsScrim: When `true`, dims media behind the panel for contrast.
    ///   - media: Figure content (image, gradient, solid).
    ///   - panel: Overlay content (title stack, icons, actions).
    public init(
        edge: HIGImageOverlayEdge = .bottom,
        showsScrim: Bool = true,
        @ViewBuilder media: @escaping () -> Media,
        @ViewBuilder panel: @escaping () -> Panel
    ) {
        self.edge = edge
        self.showsScrim = showsScrim
        self.media = media
        self.panel = panel
    }

    public var body: some View {
        let tokens = theme.imageOverlay
        let shape = RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)

        ZStack(alignment: edge.alignment) {
            media()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

            if showsScrim {
                scrimLayer(tokens: tokens, shape: shape)
                    .allowsHitTesting(false)
            }

            panel()
                .padding(tokens.panelPadding)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: edge == .full ? .infinity : nil,
                    alignment: edge == .full ? .center : .leading
                )
        }
        .frame(maxWidth: .infinity, minHeight: tokens.minHeight)
        .clipShape(shape)
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
    }

    @ViewBuilder
    private func scrimLayer(
        tokens: any HIGImageOverlayTokens,
        shape: RoundedRectangle
    ) -> some View {
        let fill = theme.colors.labelPrimary.opacity(tokens.scrimOpacity)
        switch edge {
        case .full, .center:
            shape.fill(fill)
        case .top:
            LinearGradient(
                colors: [fill, fill.opacity(theme.opacity.hidden)],
                startPoint: .top,
                endPoint: .bottom
            )
        case .bottom:
            LinearGradient(
                colors: [fill.opacity(theme.opacity.hidden), fill],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

extension HIGImageOverlay where Panel == HIGImageOverlayCaptionPanelView {
    /// Creates an image overlay with a title/subtitle caption panel.
    /// - Parameters:
    ///   - title: Primary caption.
    ///   - subtitle: Optional secondary caption.
    ///   - edge: Panel placement.
    ///   - showsScrim: Dim media for caption contrast.
    ///   - media: Figure content.
    public init(
        _ title: String,
        subtitle: String? = nil,
        edge: HIGImageOverlayEdge = .bottom,
        showsScrim: Bool = true,
        @ViewBuilder media: @escaping () -> Media
    ) {
        self.init(
            edge: edge,
            showsScrim: showsScrim,
            media: media,
            panel: {
                HIGImageOverlayCaptionPanelView(title: title, subtitle: subtitle)
            }
        )
    }
}

/// Default caption stack used by the title convenience on ``HIGImageOverlay``.
public struct HIGImageOverlayCaptionPanelView: View {
    private let title: String
    private let subtitle: String?

    @Environment(\.higTheme) private var theme

    public init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }

    public var body: some View {
        let tokens = theme.imageOverlay
        VStack(alignment: .leading, spacing: tokens.stackSpacing) {
            Text(title)
                .font(tokens.titleFont)
                .foregroundStyle(theme.colors.labelOnAccent)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityAddTraits(.isHeader)
            if let subtitle {
                Text(subtitle)
                    .font(tokens.subtitleFont)
                    .foregroundStyle(
                        theme.colors.labelOnAccent.opacity(theme.opacity.labelOnAccentSecondary)
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
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

#if DEBUG
#Preview("HIGImageOverlay") {
    struct HIGImageOverlayPreviewHostView: View {
        @Environment(\.higTheme) private var theme

        var body: some View {
            VStack(spacing: HIGSpacing.lg.rawValue) {
                HIGImageOverlay(
                    "Coastline",
                    subtitle: "Featured gallery item",
                    edge: .bottom
                ) {
                    LinearGradient(
                        colors: [theme.colors.accent, theme.colors.fillPrimary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }

                HIGImageOverlay(edge: .center, showsScrim: true) {
                    LinearGradient(
                        colors: [theme.colors.accent, theme.colors.fillPrimary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                } panel: {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: HIGSpacing.massive.rawValue))
                        .foregroundStyle(theme.colors.labelOnAccent)
                        .accessibilityLabel("Play")
                }
            }
            .padding()
        }
    }

    return HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGImageOverlayPreviewHostView()
    }
}

#Preview("HIGImageOverlayCaptionPanelView") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGImageOverlayCaptionPanelView(title: "Caption", subtitle: "Detail")
            .padding()
            .background {
                Color.primary.opacity(0.6)
            }
    }
}
#endif
