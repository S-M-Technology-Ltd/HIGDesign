import HIGFoundations
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed SF Symbol icon.
public struct HIGIcon: View {
    private let systemName: String
    private let size: HIGIconSize
    private let style: HIGIconStyle

    @Environment(\.higTheme) private var theme

    public init(
        _ systemName: String,
        size: HIGIconSize = .medium,
        style: HIGIconStyle = .primary
    ) {
        self.systemName = systemName
        self.size = size
        self.style = style
    }

    public var body: some View {
        let tokens = theme.icon
        let basePointSize = size.basePointSize(tokens: tokens)

        HIGScaledDimension(baseValue: basePointSize) { pointSize in
            Image(systemName: systemName)
                .font(.system(size: pointSize))
                .foregroundStyle(style.color(theme: theme))
                .accessibilityHidden(true)
        }
    }

}

#if DEBUG
#Preview("HIGIcon") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HStack(spacing: HIGSpacing.lg.rawValue) {
            HIGIcon("bell", size: .small)
            HIGIcon("star.fill", style: .accent)
            HIGIcon("folder", size: .large, style: .secondary)
            HIGIcon("heart.fill", size: .fixed(32), style: .tint(.pink))
        }
        .padding()
    }
}
#endif