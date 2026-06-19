import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// An indeterminate activity indicator with optional caption text.
public struct HIGActivityIndicator: View {
    private let label: String?
    private let size: HIGActivityIndicatorSize
    private let style: HIGActivityIndicatorStyle

    @Environment(\.higTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(
        _ label: String? = nil,
        size: HIGActivityIndicatorSize = .medium,
        style: HIGActivityIndicatorStyle = .system
    ) {
        self.label = label
        self.size = size
        self.style = style
    }

    public var body: some View {
        let tokens = theme.activityIndicator
        let capabilities = HIGPlatformCapabilities.current
        let scale = size.scale(for: tokens)
        let customDiameter = tokens.customDiameter * scale

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            if let label {
                Text(label)
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)
            }

            indicatorContent(
                tokens: tokens,
                capabilities: capabilities,
                scale: scale,
                customDiameter: customDiameter
            )
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label ?? "Loading")
    }

    @ViewBuilder
    private func indicatorContent(
        tokens: any HIGActivityIndicatorTokens,
        capabilities: HIGPlatformCapabilities,
        scale: CGFloat,
        customDiameter: CGFloat
    ) -> some View {
        let accent = theme.colors.accent
        let standardDuration = theme.motion.standard
        let emphasizedDuration = theme.motion.emphasized

        switch style {
        case .system:
            ProgressView()
                .controlSize(size.controlSize(for: capabilities))
                .scaleEffect(scale)
                .tint(accent)
        case .orbital:
            HIGOrbitalActivityIndicator(
                diameter: customDiameter,
                lineWidth: tokens.orbitalLineWidth,
                color: accent,
                duration: emphasizedDuration,
                reduceMotion: reduceMotion
            )
        case .pulsing:
            HIGPulsingActivityIndicator(
                diameter: customDiameter,
                segmentCount: tokens.pulsingSegmentCount,
                color: accent,
                dimmedOpacity: tokens.pulsingDimmedOpacity,
                duration: standardDuration,
                reduceMotion: reduceMotion
            )
        case .arcs:
            HIGArcsActivityIndicator(
                diameter: customDiameter,
                count: tokens.arcsCount,
                lineWidth: tokens.orbitalLineWidth,
                sweepDegrees: tokens.arcsSweepDegrees,
                rotationSpeed: tokens.arcsRotationSpeed,
                color: accent,
                duration: emphasizedDuration,
                reduceMotion: reduceMotion
            )
        case .rotatingDots:
            HIGRotatingDotsActivityIndicator(
                diameter: customDiameter,
                count: tokens.rotatingDotsCount,
                color: accent,
                duration: emphasizedDuration,
                reduceMotion: reduceMotion
            )
        case .flickeringDots:
            HIGFlickeringDotsActivityIndicator(
                diameter: customDiameter,
                count: tokens.flickeringDotsCount,
                color: accent,
                minScale: tokens.scalingDotsMinScale,
                minOpacity: tokens.pulsingDimmedOpacity,
                duration: standardDuration,
                reduceMotion: reduceMotion
            )
        case .scalingDots:
            HIGScalingDotsActivityIndicator(
                diameter: customDiameter,
                count: tokens.scalingDotsCount,
                inset: tokens.scalingDotsInset,
                minScale: tokens.scalingDotsMinScale,
                color: accent,
                duration: standardDuration,
                reduceMotion: reduceMotion
            )
        case .opacityDots:
            HIGOpacityDotsActivityIndicator(
                diameter: customDiameter,
                count: tokens.opacityDotsCount,
                inset: tokens.opacityDotsInset,
                minScale: tokens.opacityDotsMinScale,
                minOpacity: tokens.opacityDotsMinOpacity,
                color: accent,
                duration: standardDuration,
                reduceMotion: reduceMotion
            )
        case .equalizer:
            HIGEqualizerActivityIndicator(
                diameter: customDiameter,
                barCount: tokens.equalizerBarCount,
                cornerRadius: tokens.equalizerBarCornerRadius,
                minScale: tokens.equalizerMinScale,
                color: accent,
                duration: standardDuration,
                reduceMotion: reduceMotion
            )
        case .growingCircle:
            HIGGrowingCircleActivityIndicator(
                diameter: customDiameter,
                color: accent,
                fadeOpacity: tokens.growingCircleFadeOpacity,
                duration: emphasizedDuration,
                reduceMotion: reduceMotion
            )
        case .gradient:
            HIGGradientActivityIndicator(
                diameter: customDiameter,
                lineWidth: tokens.orbitalLineWidth,
                trimLeading: tokens.gradientTrimLeading,
                trimTrailing: tokens.gradientTrimTrailing,
                colors: gradientColors(accent: accent),
                duration: emphasizedDuration,
                reduceMotion: reduceMotion
            )
        }
    }

    private func gradientColors(accent: Color) -> [Color] {
        [
            accent.opacity(theme.opacity.subtleFill),
            accent,
            accent.opacity(theme.opacity.pressedSecondary),
        ]
    }
}

#if DEBUG
#Preview("HIGActivityIndicator") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        ScrollView {
            VStack(alignment: .leading, spacing: HIGSpacing.xl.rawValue) {
                ForEach(HIGActivityIndicatorStyle.allCases, id: \.self) { style in
                    HIGActivityIndicator(String(describing: style), size: .medium, style: style)
                }
            }
            .padding()
        }
    }
}
#endif