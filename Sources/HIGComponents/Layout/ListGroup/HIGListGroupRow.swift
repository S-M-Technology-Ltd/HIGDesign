import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A single row for use inside ``HIGListGroup``.
public struct HIGListGroupRow: View {
    private let title: String
    private let subtitle: String?
    private let systemImage: String?
    private let isSelected: Bool
    private let showsChevron: Bool
    private let action: (() -> Void)?

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a list group row.
    /// - Parameters:
    ///   - title: Primary label.
    ///   - subtitle: Optional secondary text.
    ///   - systemImage: Optional leading SF Symbol.
    ///   - isSelected: Highlights the row as active.
    ///   - showsChevron: When `true`, shows a trailing disclosure chevron.
    ///   - action: Optional tap handler; when set, the row is a button.
    public init(
        _ title: String,
        subtitle: String? = nil,
        systemImage: String? = nil,
        isSelected: Bool = false,
        showsChevron: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.isSelected = isSelected
        self.showsChevron = showsChevron
        self.action = action
    }

    public var body: some View {
        let tokens = theme.listGroup
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.rowMinHeight, capabilities.minimumTouchTarget)

        Group {
            if let action {
                Button(action: action) {
                    rowContent(tokens: tokens, minHeight: minHeight)
                }
                .buttonStyle(.plain)
                .disabled(!isEnabled)
            } else {
                rowContent(tokens: tokens, minHeight: minHeight)
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabelText)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityAddTraits(action != nil ? .isButton : [])
    }

    private func rowContent(tokens: any HIGListGroupTokens, minHeight: CGFloat) -> some View {
        HStack(spacing: tokens.iconSpacing) {
            if let systemImage {
                Image(systemName: systemImage)
                    .font(tokens.titleFont)
                    .foregroundStyle(isSelected ? theme.colors.accent : theme.colors.labelSecondary)
                    .frame(width: capabilitiesIconWidth(tokens: tokens), alignment: .center)
                    .accessibilityHidden(true)
            }

            VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
                Text(title)
                    .font(tokens.titleFont)
                    .foregroundStyle(isSelected ? theme.colors.accent : theme.colors.labelPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let subtitle {
                    Text(subtitle)
                        .font(tokens.subtitleFont)
                        .foregroundStyle(theme.colors.labelSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            if showsChevron {
                Image(systemName: "chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(theme.colors.labelSecondary)
                    .accessibilityHidden(true)
            }
        }
        .padding(.horizontal, tokens.horizontalPadding)
        .padding(.vertical, tokens.verticalPadding)
        .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .leading)
        .background(isSelected ? theme.colors.fillPrimary.opacity(theme.opacity.disabled) : Color.clear)
        .contentShape(Rectangle())
    }

    private func capabilitiesIconWidth(tokens: any HIGListGroupTokens) -> CGFloat {
        max(tokens.rowMinHeight * 0.5, theme.spacing.item)
    }

    private var accessibilityLabelText: String {
        if let subtitle {
            "\(title). \(subtitle)"
        } else {
            title
        }
    }
}

#if DEBUG
#Preview("HIGListGroupRow") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: 0) {
            HIGListGroupRow("Inbox", subtitle: "12 unread", systemImage: "tray", isSelected: true)
            HIGListGroupRow("Archive", systemImage: "archivebox", showsChevron: true)
        }
        .padding()
    }
}
#endif
