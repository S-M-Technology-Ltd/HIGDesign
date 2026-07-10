import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A compact presence indicator (online / away / busy / offline).
///
/// Inspired by Remark Admin status dots; colors resolve from semantic theme roles.
public struct HIGStatusIndicator: View {
    private let kind: HIGStatusKind
    private let usesAvatarBadgeSize: Bool

    @Environment(\.higTheme) private var theme

    /// Creates a status indicator.
    /// - Parameters:
    ///   - kind: Presence state.
    ///   - usesAvatarBadgeSize: When `true`, uses the smaller avatar badge diameter.
    public init(_ kind: HIGStatusKind, usesAvatarBadgeSize: Bool = false) {
        self.kind = kind
        self.usesAvatarBadgeSize = usesAvatarBadgeSize
    }

    public var body: some View {
        let tokens = theme.statusIndicator
        let diameter = usesAvatarBadgeSize ? tokens.avatarBadgeDiameter : tokens.diameter

        Circle()
            .fill(fillColor)
            .frame(width: diameter, height: diameter)
            .overlay {
                Circle()
                    .strokeBorder(theme.colors.backgroundPrimary, lineWidth: tokens.borderWidth)
            }
            .accessibilityLabel(kind.accessibilityLabel)
            .accessibilityAddTraits(.isImage)
    }

    private var fillColor: Color {
        switch kind {
        case .online:
            theme.colors.accent
        case .away:
            theme.colors.warning
        case .busy:
            theme.colors.destructive
        case .offline:
            theme.colors.labelSecondary
        }
    }
}

#if DEBUG
#Preview("HIGStatusIndicator") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HStack(spacing: HIGSpacing.lg.rawValue) {
            ForEach(HIGStatusKind.allCases, id: \.self) { kind in
                VStack {
                    HIGStatusIndicator(kind)
                    Text(kind.accessibilityLabel)
                        .font(.caption)
                }
            }
        }
        .padding()
    }
}
#endif
