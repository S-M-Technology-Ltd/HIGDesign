import HIGThemesContract
import SwiftUI

/// A vertical list of bullet items using HIG typography.
public struct HIGBulletList: View {
    private let items: [String]

    @Environment(\.higTheme) private var theme

    public init(_ items: [String]) {
        self.items = items
    }

    public var body: some View {
        let tokens = theme.bulletList

        VStack(alignment: .leading, spacing: tokens.itemSpacing) {
            ForEach(items, id: \.self) { item in
                HStack(alignment: .top, spacing: tokens.bulletSpacing) {
                    Text("•")
                        .font(tokens.font)
                        .foregroundStyle(theme.colors.labelSecondary)
                        .accessibilityHidden(true)
                    Text(item)
                        .font(tokens.font)
                        .foregroundStyle(theme.colors.labelPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .accessibilityElement(children: .combine)
    }
}

#if DEBUG
#Preview("HIGBulletList") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGBulletList([
            "Use system colors and SF Symbols first.",
            "Support Dynamic Type in every component.",
            "Document platform-specific behavior.",
        ])
        .padding()
    }
}
#endif