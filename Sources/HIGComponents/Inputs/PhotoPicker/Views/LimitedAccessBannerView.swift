#if os(iOS)
import HIGThemesContract
import SwiftUI

struct LimitedAccessBannerView: View {
    let title: String
    let description: String
    let actionTitle: String
    let isExpanded: Bool
    let headerCollapseProgress: CGFloat
    let onToggle: () -> Void
    let onManageAccess: () -> Void
    let onHeaderCollapseSwipe: (PickerHeaderSwipeDirection) -> Void

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }
    private var layout: PickerLayout { PickerLayout(tokens: tokens) }

    private var detailsRevealProgress: CGFloat {
        layout.limitedBannerDetailsReveal(
            isExpanded: isExpanded,
            headerCollapseProgress: headerCollapseProgress
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: tokens.stackSpacingNone) {
            toggleRow

            if detailsRevealProgress > 0.001 {
                expandedDetails
                    .padding(.top, tokens.limitedBannerExpandedSpacing)
                    .opacity(detailsRevealProgress)
                    .frame(
                        height: tokens.limitedBannerDetailsHeight * detailsRevealProgress,
                        alignment: .top
                    )
            }
        }
        .padding(.horizontal, tokens.limitedBannerHorizontalInset)
        .padding(.vertical, tokens.limitedBannerExpandedVerticalPadding)
        .frame(maxWidth: .infinity, minHeight: tokens.limitedBannerToggleHeight, alignment: .topLeading)
        .background(bannerBackground)
        .background(Color.clear)
        .contentShape(Rectangle())
        .pickerHeaderCollapseSwipe(tokens: tokens, onSwipe: onHeaderCollapseSwipe)
    }

    private var toggleRow: some View {
        HStack(alignment: .center, spacing: tokens.limitedBannerTitleActionSpacing) {
            Text(title)
                .font(.footnote.weight(.semibold))
                .foregroundStyle(theme.colors.labelPrimary)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)

            toggleButton
        }
        .frame(height: tokens.limitedBannerChromeButtonHeight, alignment: .center)
    }

    private var expandedDetails: some View {
        VStack(alignment: .leading, spacing: tokens.limitedBannerActionSpacing) {
            Text(description)
                .font(.caption)
                .foregroundStyle(theme.colors.labelSecondary)
                .fixedSize(horizontal: false, vertical: true)

            manageAccessButton
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, tokens.limitedBannerManageAccessTopPadding)
        }
    }

    @ViewBuilder
    private var bannerBackground: some View {
        if detailsRevealProgress > 0.001 {
            RoundedRectangle(cornerRadius: tokens.limitedBannerCornerRadius, style: .continuous)
                .fill(tokens.limitedBannerPanelBackground)
                .opacity(detailsRevealProgress)
        }
    }

    private var toggleButton: some View {
        PickerChromeIconButtonView(
            systemImage: isExpanded ? "chevron.up" : "chevron.down",
            accessibilityLabel: title,
            accessibilityHint: isExpanded
                ? "Collapse limited access details"
                : "Expand limited access details",
            sizing: .banner,
            action: onToggle
        )
        .frame(
            width: tokens.limitedBannerChromeButtonHeight,
            height: tokens.limitedBannerChromeButtonHeight
        )
    }

    private var manageAccessButton: some View {
        PickerChromeLabelButtonView(
            title: actionTitle,
            systemImage: "photo.badge.plus",
            accessibilityHint: "Opens the limited photo library picker",
            sizing: .banner,
            action: onManageAccess
        )
        .frame(height: tokens.limitedBannerChromeButtonHeight)
    }
}

#if DEBUG
#Preview("Collapsed") {
    LimitedAccessBannerView(
        title: "Limited Access",
        description: "You've granted access to only a subset of your photo library. Choose additional photos and albums that can be used in this app.",
        actionTitle: "Add more photos",
        isExpanded: false,
        headerCollapseProgress: 0,
        onToggle: {},
        onManageAccess: {},
        onHeaderCollapseSwipe: { _ in }
    )
    .background(HIGSystemPhotoPickerTokens().chromeBackground)
}

#Preview("Expanded") {
    LimitedAccessBannerView(
        title: "Limited Access",
        description: "You've granted access to only a subset of your photo library. Choose additional photos and albums that can be used in this app.",
        actionTitle: "Add more photos",
        isExpanded: true,
        headerCollapseProgress: 0,
        onToggle: {},
        onManageAccess: {},
        onHeaderCollapseSwipe: { _ in }
    )
    .background(HIGSystemPhotoPickerTokens().chromeBackground)
}

#Preview("Collapsed Header Expanded Banner") {
    LimitedAccessBannerView(
        title: "Limited Access",
        description: "You've granted access to only a subset of your photo library. Choose additional photos and albums that can be used in this app.",
        actionTitle: "Add more photos",
        isExpanded: true,
        headerCollapseProgress: 1,
        onToggle: {},
        onManageAccess: {},
        onHeaderCollapseSwipe: { _ in }
    )
    .background(HIGSystemPhotoPickerTokens().chromeBackground)
}

#Preview("Collapsing Header") {
    let tokens = HIGSystemPhotoPickerTokens()
    LimitedAccessBannerView(
        title: "Limited Access",
        description: "You've granted access to only a subset of your photo library. Choose additional photos and albums that can be used in this app.",
        actionTitle: "Add more photos",
        isExpanded: true,
        headerCollapseProgress: 0.35,
        onToggle: {},
        onManageAccess: {},
        onHeaderCollapseSwipe: { _ in }
    )
    .frame(height: tokens.limitedBannerToggleHeight + tokens.limitedBannerDetailsHeight * 0.4)
    .clipped()
    .background(tokens.chromeBackground)
}
#endif
#endif