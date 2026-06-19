#if os(iOS)
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

enum PickerHeaderSwipeDirection {
    case up
    case down
}

struct PickerCollapsibleHeader<Preview: View, Banner: View>: View {
    let containerWidth: CGFloat
    let showsBanner: Bool
    let isBannerExpanded: Bool
    let collapseProgress: CGFloat
    let localization: any HIGPhotoLocalizationProviding
    let onCollapseSwipe: (PickerHeaderSwipeDirection) -> Void
    @ViewBuilder let preview: (_ height: CGFloat) -> Preview
    @ViewBuilder let banner: () -> Banner

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }
    private var layout: PickerLayout { PickerLayout(tokens: tokens) }

    private var grabberHeight: CGFloat { tokens.headerGrabberHeight }
    private var toggleHeight: CGFloat { showsBanner ? tokens.limitedBannerToggleHeight : 0 }
    private var detailsHeight: CGFloat {
        showsBanner && isBannerExpanded ? tokens.limitedBannerDetailsHeight : 0
    }

    private var bannerDetailsSpacing: CGFloat {
        showsBanner && isBannerExpanded ? tokens.limitedBannerExpandedSpacing : 0
    }

    private var bannerDetailsReveal: CGFloat {
        guard showsBanner else { return 0 }
        return layout.limitedBannerDetailsReveal(
            isExpanded: isBannerExpanded,
            headerCollapseProgress: collapseProgress
        )
    }

    private var bannerHeight: CGFloat {
        toggleHeight + (detailsHeight + bannerDetailsSpacing) * bannerDetailsReveal
    }

    private var minPreviewSide: CGFloat { containerWidth * tokens.minPreviewScale }

    private var currentPreviewSide: CGFloat {
        containerWidth + (minPreviewSide - containerWidth) * collapseProgress
    }

    private var visibleHeight: CGFloat {
        layout.collapsibleHeaderHeight(
            containerWidth: containerWidth,
            showsBanner: showsBanner,
            isBannerExpanded: isBannerExpanded,
            collapseProgress: collapseProgress
        )
    }

    var body: some View {
        VStack(spacing: tokens.stackSpacingNone) {
            preview(currentPreviewSide)
                .frame(maxWidth: .infinity)
                .frame(height: currentPreviewSide, alignment: .top)
                .clipped()

            if showsBanner {
                banner()
                    .frame(maxWidth: .infinity, minHeight: bannerHeight, alignment: .top)
            }

            headerGrabber
        }
        .frame(maxWidth: .infinity)
        .frame(height: visibleHeight, alignment: .top)
        .contentShape(Rectangle())
        .pickerHeaderCollapseSwipe(tokens: tokens, onSwipe: onCollapseSwipe)
        .clipped()
    }

    private var headerGrabber: some View {
        VStack(spacing: tokens.stackSpacingNone) {
            Capsule()
                .fill(theme.colors.labelSecondary.opacity(tokens.grabberOpacity))
                .frame(width: tokens.headerGrabberWidth, height: tokens.headerGrabberThickness)
                .padding(.top, tokens.headerGrabberVerticalPadding)
                .padding(.bottom, tokens.headerGrabberVerticalPadding)
        }
        .frame(maxWidth: .infinity)
        .frame(height: grabberHeight)
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel(localization.pickerCollapseHeaderAccessibilityLabel())
        .accessibilityHint(localization.pickerCollapseHeaderAccessibilityHint(isCollapsed: collapseProgress > 0.5))
    }
}
#endif