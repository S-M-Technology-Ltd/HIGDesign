import CoreGraphics
import SwiftUI
import HIGTokensRaw
import HIGTokensSemantic

public protocol HIGPhotoPickerTokens: Sendable {
    var gridColumnCount: Int { get }
    var gridSpacing: CGFloat { get }
    var fallbackLayoutWidth: CGFloat { get }
    var defaultDisplayScale: CGFloat { get }

    var gridBackground: Color { get }
    var chromeBackground: Color { get }
    var previewBackground: Color { get }
    var placeholderFill: Color { get }
    var bannerBackground: Color { get }
    var limitedBannerPanelBackground: Color { get }

    var selectionOverlayOpacity: CGFloat { get }
    var compositionGridLineOpacity: CGFloat { get }
    var compositionGridLineWidth: CGFloat { get }
    var grabberOpacity: CGFloat { get }
    var badgeShadowOpacity: CGFloat { get }
    var badgeShadowRadius: CGFloat { get }
    var badgeShadowYOffset: CGFloat { get }

    var albumThumbnailSize: CGFloat { get }
    var albumThumbnailCornerRadius: CGFloat { get }
    var albumListRowSpacing: CGFloat { get }
    var albumListRowMinHeight: CGFloat { get }
    var albumListRowInsetVertical: CGFloat { get }
    var albumListRowInsetHorizontal: CGFloat { get }
    var albumListSubtitleSpacing: CGFloat { get }
    var albumListEmptyStatePadding: CGFloat { get }
    var albumListEmptyIconSize: CGFloat { get }

    var selectionBadgeSize: CGFloat { get }
    var selectionBadgePadding: CGFloat { get }
    var iCloudBadgeInnerPadding: CGFloat { get }

    var permissionHorizontalPadding: CGFloat { get }
    var permissionSectionSpacing: CGFloat { get }
    var permissionItemSpacing: CGFloat { get }
    var permissionIconSize: CGFloat { get }

    var headerGrabberHeight: CGFloat { get }
    var headerGrabberWidth: CGFloat { get }
    var headerGrabberThickness: CGFloat { get }
    var headerGrabberVerticalPadding: CGFloat { get }
    var minPreviewScale: CGFloat { get }
    var previewZoomHeadroom: CGFloat { get }
    var previewMinimumLoadSide: CGFloat { get }
    var previewMaximumZoomScale: CGFloat { get }
    var headerCollapseSwipeMinimumDistance: CGFloat { get }
    var headerCollapseSwipeActivationDistance: CGFloat { get }

    var limitedBannerChromeButtonVerticalPadding: CGFloat { get }
    var limitedBannerChromeButtonHorizontalPadding: CGFloat { get }
    var limitedBannerChromeButtonHeight: CGFloat { get }
    var limitedBannerChromeBleedInset: CGFloat { get }
    var limitedBannerToggleHeight: CGFloat { get }
    var limitedBannerDetailsHeight: CGFloat { get }
    var limitedBannerExpandedSpacing: CGFloat { get }
    var limitedBannerActionSpacing: CGFloat { get }
    var limitedBannerExpandedBottomPadding: CGFloat { get }
    var limitedBannerExpandedVerticalPadding: CGFloat { get }
    var limitedBannerHorizontalInset: CGFloat { get }
    var limitedBannerCornerRadius: CGFloat { get }
    var limitedBannerTitleActionSpacing: CGFloat { get }
    var limitedBannerManageAccessTopPadding: CGFloat { get }

    var loadingProgressSpacing: CGFloat { get }
    var loadingProgressPadding: CGFloat { get }
    var loadingProgressMaxWidth: CGFloat { get }
    var loadingProgressCornerRadius: CGFloat { get }

    var toolbarChromeInset: CGFloat { get }

    var stackSpacingNone: CGFloat { get }
    var navigationTitleSpacing: CGFloat { get }

    var bannerDetailsRevealMultiplier: CGFloat { get }
    var bannerDetailsRevealEpsilon: CGFloat { get }
}

public struct HIGSystemPhotoPickerTokens: HIGPhotoPickerTokens, Sendable {
    public let gridColumnCount: Int
    public let gridSpacing: CGFloat
    public let fallbackLayoutWidth: CGFloat
    public let defaultDisplayScale: CGFloat

    public let gridBackground: Color
    public let chromeBackground: Color
    public let previewBackground: Color
    public let placeholderFill: Color
    public let bannerBackground: Color
    public let limitedBannerPanelBackground: Color

    public let selectionOverlayOpacity: CGFloat
    public let compositionGridLineOpacity: CGFloat
    public let compositionGridLineWidth: CGFloat
    public let grabberOpacity: CGFloat
    public let badgeShadowOpacity: CGFloat
    public let badgeShadowRadius: CGFloat
    public let badgeShadowYOffset: CGFloat

    public let albumThumbnailSize: CGFloat
    public let albumThumbnailCornerRadius: CGFloat
    public let albumListRowSpacing: CGFloat
    public let albumListRowMinHeight: CGFloat
    public let albumListRowInsetVertical: CGFloat
    public let albumListRowInsetHorizontal: CGFloat
    public let albumListSubtitleSpacing: CGFloat
    public let albumListEmptyStatePadding: CGFloat
    public let albumListEmptyIconSize: CGFloat

    public let selectionBadgeSize: CGFloat
    public let selectionBadgePadding: CGFloat
    public let iCloudBadgeInnerPadding: CGFloat

    public let permissionHorizontalPadding: CGFloat
    public let permissionSectionSpacing: CGFloat
    public let permissionItemSpacing: CGFloat
    public let permissionIconSize: CGFloat

    public let headerGrabberHeight: CGFloat
    public let headerGrabberWidth: CGFloat
    public let headerGrabberThickness: CGFloat
    public let headerGrabberVerticalPadding: CGFloat
    public let minPreviewScale: CGFloat
    public let previewZoomHeadroom: CGFloat
    public let previewMinimumLoadSide: CGFloat
    public let previewMaximumZoomScale: CGFloat
    public let headerCollapseSwipeMinimumDistance: CGFloat
    public let headerCollapseSwipeActivationDistance: CGFloat

    public let limitedBannerChromeButtonVerticalPadding: CGFloat
    public let limitedBannerChromeButtonHorizontalPadding: CGFloat
    public let limitedBannerChromeButtonHeight: CGFloat
    public let limitedBannerChromeBleedInset: CGFloat
    public let limitedBannerToggleHeight: CGFloat
    public let limitedBannerDetailsHeight: CGFloat
    public let limitedBannerExpandedSpacing: CGFloat
    public let limitedBannerActionSpacing: CGFloat
    public let limitedBannerExpandedBottomPadding: CGFloat
    public let limitedBannerExpandedVerticalPadding: CGFloat
    public let limitedBannerHorizontalInset: CGFloat
    public let limitedBannerCornerRadius: CGFloat
    public let limitedBannerTitleActionSpacing: CGFloat
    public let limitedBannerManageAccessTopPadding: CGFloat

    public let loadingProgressSpacing: CGFloat
    public let loadingProgressPadding: CGFloat
    public let loadingProgressMaxWidth: CGFloat
    public let loadingProgressCornerRadius: CGFloat

    public let toolbarChromeInset: CGFloat

    public let stackSpacingNone: CGFloat
    public let navigationTitleSpacing: CGFloat

    public let bannerDetailsRevealMultiplier: CGFloat
    public let bannerDetailsRevealEpsilon: CGFloat

    public init(
        gridColumnCount: Int = 3,
        gridSpacing: CGFloat = 1,
        fallbackLayoutWidth: CGFloat = 390,
        defaultDisplayScale: CGFloat = 3,
        gridBackground: Color? = nil,
        chromeBackground: Color? = nil,
        previewBackground: Color? = nil,
        placeholderFill: Color? = nil,
        bannerBackground: Color? = nil,
        limitedBannerPanelBackground: Color? = nil,
        selectionOverlayOpacity: CGFloat = 0.15,
        compositionGridLineOpacity: CGFloat = 0.2,
        compositionGridLineWidth: CGFloat = 1,
        grabberOpacity: CGFloat = 0.35,
        badgeShadowOpacity: CGFloat = 0.2,
        badgeShadowRadius: CGFloat = 1,
        badgeShadowYOffset: CGFloat = 1,
        albumThumbnailSize: CGFloat = 56,
        albumThumbnailCornerRadius: CGFloat = 10,
        albumListRowSpacing: CGFloat = HIGSpacing.md.rawValue,
        albumListRowMinHeight: CGFloat = 60,
        albumListRowInsetVertical: CGFloat = HIGSpacing.xs.rawValue,
        albumListRowInsetHorizontal: CGFloat = HIGSpacing.lg.rawValue,
        albumListSubtitleSpacing: CGFloat = HIGSpacing.xxs.rawValue,
        albumListEmptyStatePadding: CGFloat = HIGSpacing.xxxl.rawValue,
        albumListEmptyIconSize: CGFloat = 44,
        selectionBadgeSize: CGFloat = 22,
        selectionBadgePadding: CGFloat = HIGSpacing.xs.rawValue,
        iCloudBadgeInnerPadding: CGFloat = 5,
        permissionHorizontalPadding: CGFloat = HIGSpacing.xxxl.rawValue,
        permissionSectionSpacing: CGFloat = HIGSpacing.xxl.rawValue,
        permissionItemSpacing: CGFloat = HIGSpacing.md.rawValue,
        permissionIconSize: CGFloat = 56,
        headerGrabberHeight: CGFloat = 17,
        headerGrabberWidth: CGFloat = HIGSpacing.xxxl.rawValue,
        headerGrabberThickness: CGFloat = HIGSpacing.xxs.rawValue,
        headerGrabberVerticalPadding: CGFloat = HIGSpacing.xs.rawValue,
        minPreviewScale: CGFloat = 0.32,
        previewZoomHeadroom: CGFloat = 4,
        previewMinimumLoadSide: CGFloat = 320,
        previewMaximumZoomScale: CGFloat = 4,
        headerCollapseSwipeMinimumDistance: CGFloat = HIGSpacing.md.rawValue,
        headerCollapseSwipeActivationDistance: CGFloat = HIGSpacing.huge.rawValue,
        limitedBannerChromeButtonVerticalPadding: CGFloat = HIGSpacing.sm.rawValue,
        limitedBannerChromeButtonHorizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        limitedBannerChromeButtonHeight: CGFloat = HIGSpacing.xxxl.rawValue,
        limitedBannerChromeBleedInset: CGFloat = HIGSpacing.xxs.rawValue,
        limitedBannerToggleHeight: CGFloat = HIGSpacing.huge.rawValue,
        limitedBannerDetailsHeight: CGFloat = 82,
        limitedBannerExpandedSpacing: CGFloat = HIGSpacing.xxs.rawValue,
        limitedBannerActionSpacing: CGFloat = HIGSpacing.sm.rawValue,
        limitedBannerExpandedBottomPadding: CGFloat = HIGSpacing.sm.rawValue,
        limitedBannerExpandedVerticalPadding: CGFloat = HIGSpacing.xxs.rawValue,
        limitedBannerHorizontalInset: CGFloat = HIGSpacing.md.rawValue,
        limitedBannerCornerRadius: CGFloat = 10,
        limitedBannerTitleActionSpacing: CGFloat = HIGSpacing.sm.rawValue,
        limitedBannerManageAccessTopPadding: CGFloat = HIGSpacing.sm.rawValue,
        loadingProgressSpacing: CGFloat = HIGSpacing.md.rawValue,
        loadingProgressPadding: CGFloat = HIGSpacing.lg.rawValue,
        loadingProgressMaxWidth: CGFloat = 240,
        loadingProgressCornerRadius: CGFloat = HIGRadius.lg.rawValue,
        toolbarChromeInset: CGFloat = 3,
        stackSpacingNone: CGFloat = 0,
        navigationTitleSpacing: CGFloat = HIGSpacing.xxs.rawValue,
        bannerDetailsRevealMultiplier: CGFloat = 4,
        bannerDetailsRevealEpsilon: CGFloat = 0.01
    ) {
        self.gridColumnCount = gridColumnCount
        self.gridSpacing = gridSpacing
        self.fallbackLayoutWidth = fallbackLayoutWidth
        self.defaultDisplayScale = defaultDisplayScale
        self.gridBackground = gridBackground ?? HIGPlatformColor.systemBackground
        self.chromeBackground = chromeBackground ?? HIGPlatformColor.systemGroupedBackground
        self.previewBackground = previewBackground ?? HIGPlatformColor.secondarySystemBackground
        self.placeholderFill = placeholderFill ?? HIGPlatformColor.quaternarySystemFill
        self.bannerBackground = bannerBackground ?? HIGPlatformColor.tertiarySystemFill
        self.limitedBannerPanelBackground = limitedBannerPanelBackground ?? HIGPlatformColor.secondarySystemGroupedBackground
        self.selectionOverlayOpacity = selectionOverlayOpacity
        self.compositionGridLineOpacity = compositionGridLineOpacity
        self.compositionGridLineWidth = compositionGridLineWidth
        self.grabberOpacity = grabberOpacity
        self.badgeShadowOpacity = badgeShadowOpacity
        self.badgeShadowRadius = badgeShadowRadius
        self.badgeShadowYOffset = badgeShadowYOffset
        self.albumThumbnailSize = albumThumbnailSize
        self.albumThumbnailCornerRadius = albumThumbnailCornerRadius
        self.albumListRowSpacing = albumListRowSpacing
        self.albumListRowMinHeight = albumListRowMinHeight
        self.albumListRowInsetVertical = albumListRowInsetVertical
        self.albumListRowInsetHorizontal = albumListRowInsetHorizontal
        self.albumListSubtitleSpacing = albumListSubtitleSpacing
        self.albumListEmptyStatePadding = albumListEmptyStatePadding
        self.albumListEmptyIconSize = albumListEmptyIconSize
        self.selectionBadgeSize = selectionBadgeSize
        self.selectionBadgePadding = selectionBadgePadding
        self.iCloudBadgeInnerPadding = iCloudBadgeInnerPadding
        self.permissionHorizontalPadding = permissionHorizontalPadding
        self.permissionSectionSpacing = permissionSectionSpacing
        self.permissionItemSpacing = permissionItemSpacing
        self.permissionIconSize = permissionIconSize
        self.headerGrabberHeight = headerGrabberHeight
        self.headerGrabberWidth = headerGrabberWidth
        self.headerGrabberThickness = headerGrabberThickness
        self.headerGrabberVerticalPadding = headerGrabberVerticalPadding
        self.minPreviewScale = minPreviewScale
        self.previewZoomHeadroom = previewZoomHeadroom
        self.previewMinimumLoadSide = previewMinimumLoadSide
        self.previewMaximumZoomScale = previewMaximumZoomScale
        self.headerCollapseSwipeMinimumDistance = headerCollapseSwipeMinimumDistance
        self.headerCollapseSwipeActivationDistance = headerCollapseSwipeActivationDistance
        self.limitedBannerChromeButtonVerticalPadding = limitedBannerChromeButtonVerticalPadding
        self.limitedBannerChromeButtonHorizontalPadding = limitedBannerChromeButtonHorizontalPadding
        self.limitedBannerChromeButtonHeight = limitedBannerChromeButtonHeight
        self.limitedBannerChromeBleedInset = limitedBannerChromeBleedInset
        self.limitedBannerToggleHeight = limitedBannerToggleHeight
        self.limitedBannerDetailsHeight = limitedBannerDetailsHeight
        self.limitedBannerExpandedSpacing = limitedBannerExpandedSpacing
        self.limitedBannerActionSpacing = limitedBannerActionSpacing
        self.limitedBannerExpandedBottomPadding = limitedBannerExpandedBottomPadding
        self.limitedBannerExpandedVerticalPadding = limitedBannerExpandedVerticalPadding
        self.limitedBannerHorizontalInset = limitedBannerHorizontalInset
        self.limitedBannerCornerRadius = limitedBannerCornerRadius
        self.limitedBannerTitleActionSpacing = limitedBannerTitleActionSpacing
        self.limitedBannerManageAccessTopPadding = limitedBannerManageAccessTopPadding
        self.loadingProgressSpacing = loadingProgressSpacing
        self.loadingProgressPadding = loadingProgressPadding
        self.loadingProgressMaxWidth = loadingProgressMaxWidth
        self.loadingProgressCornerRadius = loadingProgressCornerRadius
        self.toolbarChromeInset = toolbarChromeInset
        self.stackSpacingNone = stackSpacingNone
        self.navigationTitleSpacing = navigationTitleSpacing
        self.bannerDetailsRevealMultiplier = bannerDetailsRevealMultiplier
        self.bannerDetailsRevealEpsilon = bannerDetailsRevealEpsilon
    }
}