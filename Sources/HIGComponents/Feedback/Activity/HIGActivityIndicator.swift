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
        switch style {
        case .system:
            ProgressView()
                .controlSize(size.controlSize(for: capabilities))
                .scaleEffect(scale)
                .tint(theme.colors.accent)
        case .orbital:
            HIGOrbitalActivityIndicator(
                diameter: customDiameter,
                lineWidth: tokens.orbitalLineWidth,
                color: theme.colors.accent,
                duration: theme.motion.emphasized,
                reduceMotion: reduceMotion
            )
        case .pulsing:
            HIGPulsingActivityIndicator(
                diameter: customDiameter,
                segmentCount: tokens.pulsingSegmentCount,
                color: theme.colors.accent,
                dimmedOpacity: tokens.pulsingDimmedOpacity,
                duration: theme.motion.standard,
                reduceMotion: reduceMotion
            )
        }
    }
}

#if DEBUG
#Preview("HIGActivityIndicator") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(alignment: .leading, spacing: HIGSpacing.xl.rawValue) {
            HIGActivityIndicator("System", size: .medium, style: .system)
            HIGActivityIndicator("Orbital", size: .medium, style: .orbital)
            HIGActivityIndicator("Pulsing", size: .medium, style: .pulsing)
        }
        .padding()
    }
}
#endif