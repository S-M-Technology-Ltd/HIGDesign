import HIGThemesContract
import HIGTokensRaw
import SwiftUI

/// A horizontal rule that uses the active theme separator color.
public struct HIGDivider: View {
    public init() {}

    @Environment(\.higTheme) private var theme

    public var body: some View {
        Rectangle()
            .fill(theme.colors.separator)
            .frame(height: theme.divider.thickness)
            .accessibilityHidden(true)
    }
}

#if DEBUG
#Preview("HIGDivider") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: HIGSpacing.lg.rawValue) {
            Text("Above")
            HIGDivider()
            Text("Below")
        }
        .padding()
    }
}
#endif