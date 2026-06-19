import HIGThemesContract
import SwiftUI

/// A circular avatar with initials or a fallback symbol.
public struct HIGAvatar: View {
    private let initials: String
    private let systemImage: String?

    @Environment(\.higTheme) private var theme

    public init(_ initials: String, systemImage: String? = nil) {
        self.initials = String(initials.prefix(2)).uppercased()
        self.systemImage = systemImage
    }

    public var body: some View {
        let tokens = theme.avatar

        ZStack {
            Circle()
                .fill(theme.colors.fillPrimary)

            if let systemImage {
                Image(systemName: systemImage)
                    .font(tokens.font)
                    .foregroundStyle(theme.colors.labelSecondary)
            } else {
                Text(initials)
                    .font(tokens.font)
                    .foregroundStyle(theme.colors.labelPrimary)
            }
        }
        .frame(width: tokens.diameter, height: tokens.diameter)
        .accessibilityLabel(initials.isEmpty ? "Avatar" : "Avatar \(initials)")
    }
}

#if DEBUG
#Preview("HIGAvatar") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HStack(spacing: 16) {
            HIGAvatar("AR")
            HIGAvatar("Sam")
            HIGAvatar("", systemImage: "person.fill")
        }
        .padding()
    }
}
#endif