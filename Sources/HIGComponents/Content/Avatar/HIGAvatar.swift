import HIGThemesContract
import HIGTokensRaw
import SwiftUI

/// A circular avatar with initials or a fallback symbol.
public struct HIGAvatar: View {
    private let initials: String
    private let systemImage: String?
    private let status: HIGStatusKind?

    @Environment(\.higTheme) private var theme

    public init(
        _ initials: String,
        systemImage: String? = nil,
        status: HIGStatusKind? = nil
    ) {
        self.initials = String(initials.prefix(2)).uppercased()
        self.systemImage = systemImage
        self.status = status
    }

    public var body: some View {
        let tokens = theme.avatar
        let statusTokens = theme.statusIndicator

        ZStack(alignment: .bottomTrailing) {
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

            if let status {
                HIGStatusIndicator(status, usesAvatarBadgeSize: true)
                    .offset(
                        x: statusTokens.avatarBadgeDiameter / 4,
                        y: statusTokens.avatarBadgeDiameter / 4
                    )
            }
        }
        .accessibilityLabel(accessibilityLabelText)
    }

    private var accessibilityLabelText: String {
        let base = initials.isEmpty ? "Avatar" : "Avatar \(initials)"
        if let status {
            return "\(base), \(status.accessibilityLabel)"
        }
        return base
    }
}

#if DEBUG
#Preview("HIGAvatar") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HStack(spacing: HIGSpacing.lg.rawValue) {
            HIGAvatar("AR")
            HIGAvatar("Sam", status: .online)
            HIGAvatar("", systemImage: "person.fill", status: .busy)
        }
        .padding()
    }
}
#endif
