import HIGFoundations
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A themed Heroicons v2 icon rendered from tokenized SVG path data.
public struct HIGHeroIcon: View {
    private let descriptor: HIGHeroIconDescriptor
    private let size: HIGIconSize
    private let style: HIGIconStyle

    @Environment(\.higTheme) private var theme

    public init(
        _ token: HIGHeroIconToken,
        variant: HIGHeroIconVariant,
        size: HIGIconSize = .medium,
        style: HIGIconStyle = .primary
    ) {
        self.descriptor = HIGHeroIconDescriptor(token: token, variant: variant)
        self.size = size
        self.style = style
    }

    public init(
        descriptor: HIGHeroIconDescriptor,
        size: HIGIconSize = .medium,
        style: HIGIconStyle = .primary
    ) {
        self.descriptor = descriptor
        self.size = size
        self.style = style
    }

    public var body: some View {
        let tokens = theme.icon
        let basePointSize = size.basePointSize(tokens: tokens)
        let shape = HIGHeroIconShape(token: descriptor.token, variant: descriptor.variant)
        let color = style.color(theme: theme)

        HIGScaledDimension(baseValue: basePointSize) { pointSize in
            if let entry = HIGHeroIconCatalog.entry(for: descriptor.token, variant: descriptor.variant),
               entry.renderMode == .stroke {
                shape
                    .stroke(
                        color,
                        style: StrokeStyle(
                            lineWidth: entry.strokeWidth * (pointSize / 24),
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .frame(width: pointSize, height: pointSize)
                    .accessibilityHidden(true)
            } else {
                shape
                    .fill(color)
                    .frame(width: pointSize, height: pointSize)
                    .accessibilityHidden(true)
            }
        }
    }

}

#if DEBUG
#Preview("HIGHeroIcon") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HStack(spacing: 16) {
            HIGHeroIcon(.academicCap, variant: .outline)
            HIGHeroIcon(.academicCap, variant: .solid, style: .accent)
            HIGHeroIcon(.bell, variant: .outline, size: .large)
            HIGHeroIcon(.heart, variant: .solid, size: .fixed(32), style: .tint(.pink))
        }
        .padding()
    }
}
#endif