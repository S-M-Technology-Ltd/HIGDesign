import HIGThemesContract
import HIGTokensComponent
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

        Image(systemName: systemName)
            .font(.system(size: pointSize(tokens: tokens)))
            .foregroundStyle(style.color(theme: theme))
            .accessibilityHidden(true)
    }

    private func pointSize(tokens: any HIGIconTokens) -> CGFloat {
        switch size {
        case .small:
            tokens.smallSize
        case .medium:
            tokens.mediumSize
        case .large:
            tokens.largeSize
        }
    }
}

#if DEBUG
#Preview("HIGIcon") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HStack(spacing: 16) {
            HIGIcon("bell", size: .small)
            HIGIcon("star.fill", style: .accent)
            HIGIcon("folder", size: .large, style: .secondary)
        }
        .padding()
    }
}
#endif