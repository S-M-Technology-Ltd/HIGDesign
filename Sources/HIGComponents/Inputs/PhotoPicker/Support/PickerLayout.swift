#if os(iOS)
import SwiftUI
import HIGTokensComponent

struct PickerLayout {
    let tokens: any HIGPhotoPickerTokens

    func pixelAlignedLength(_ value: CGFloat, scale: CGFloat? = nil) -> CGFloat {
        let resolvedScale = scale ?? tokens.defaultDisplayScale
        guard value > 0 else { return 0 }
        return floor(value * resolvedScale) / resolvedScale
    }

    func gridCellSideLength(containerWidth: CGFloat) -> CGFloat {
        guard containerWidth > 0 else { return 0 }
        let columns = CGFloat(tokens.gridColumnCount)
        let columnGaps = tokens.gridSpacing * (columns - 1)
        let raw = floor((containerWidth - columnGaps) / columns)
        return pixelAlignedLength(raw)
    }

    func gridHorizontalAlignmentInset(containerWidth: CGFloat, cellSide: CGFloat) -> CGFloat {
        let columns = CGFloat(tokens.gridColumnCount)
        let gridWidth = columns * cellSide + tokens.gridSpacing * (columns - 1)
        return max(0, (containerWidth - gridWidth) / 2)
    }

    func gridRows(
        assets: [HIGPhotoAsset],
        columnCount: Int? = nil
    ) -> [PhotoGridRowModel] {
        let resolvedColumnCount = columnCount ?? tokens.gridColumnCount
        guard resolvedColumnCount > 0, !assets.isEmpty else { return [] }

        return stride(from: 0, to: assets.count, by: resolvedColumnCount).map { start in
            let slice = Array(assets[start..<min(start + resolvedColumnCount, assets.count)])
            return PhotoGridRowModel(id: slice[0].id, assets: slice)
        }
    }

    func limitedBannerDetailsReveal(
        isExpanded: Bool,
        headerCollapseProgress: CGFloat
    ) -> CGFloat {
        guard isExpanded else { return 0 }
        if headerCollapseProgress <= tokens.bannerDetailsRevealEpsilon
            || headerCollapseProgress >= 1 - tokens.bannerDetailsRevealEpsilon {
            return 1
        }
        return max(0, 1 - headerCollapseProgress * tokens.bannerDetailsRevealMultiplier)
    }

    func collapsibleHeaderHeight(
        containerWidth: CGFloat,
        showsBanner: Bool,
        isBannerExpanded: Bool,
        collapseProgress: CGFloat
    ) -> CGFloat {
        let minPreviewSide = containerWidth * tokens.minPreviewScale
        let currentPreviewSide = containerWidth + (minPreviewSide - containerWidth) * collapseProgress

        let toggleHeight: CGFloat = showsBanner ? tokens.limitedBannerToggleHeight : 0
        let detailsHeight: CGFloat = showsBanner && isBannerExpanded ? tokens.limitedBannerDetailsHeight : 0
        let bannerDetailsSpacing: CGFloat = showsBanner && isBannerExpanded ? tokens.limitedBannerExpandedSpacing : 0
        let bannerDetailsReveal = showsBanner
            ? limitedBannerDetailsReveal(
                isExpanded: isBannerExpanded,
                headerCollapseProgress: collapseProgress
            )
            : 0
        let bannerHeight = toggleHeight + (detailsHeight + bannerDetailsSpacing) * bannerDetailsReveal

        return pixelAlignedLength(currentPreviewSide + bannerHeight + tokens.headerGrabberHeight)
    }

    var limitedBannerChromeBleedInsetInsets: EdgeInsets {
        let inset = tokens.limitedBannerChromeBleedInset
        return EdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
    }
}
#endif