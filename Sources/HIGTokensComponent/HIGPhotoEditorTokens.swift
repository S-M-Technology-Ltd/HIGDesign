import HIGTokensRaw
import HIGTokensSemantic
import SwiftUI

public protocol HIGPhotoEditorTokens: Sendable {
    var canvasBackground: Color { get }
    var overlayDimmingOpacity: CGFloat { get }
    var cropBorderWidth: CGFloat { get }
    var compositionGridLineOpacity: CGFloat { get }
    var compositionGridLineWidth: CGFloat { get }
    var toolbarBackground: Color { get }
    var toolbarChromeInset: CGFloat { get }
    var toolbarActionSpacing: CGFloat { get }
    var toolbarVerticalPadding: CGFloat { get }
    var toolbarHorizontalPadding: CGFloat { get }
    var cropRegionHorizontalInset: CGFloat { get }
    var cropRegionVerticalInset: CGFloat { get }
    var minimumCropRegionSide: CGFloat { get }
    var maximumZoomScale: CGFloat { get }
    var fallbackLayoutWidth: CGFloat { get }
    var fallbackLayoutHeight: CGFloat { get }
}

public struct HIGSystemPhotoEditorTokens: HIGPhotoEditorTokens, Sendable {
    public let canvasBackground: Color
    public let overlayDimmingOpacity: CGFloat
    public let cropBorderWidth: CGFloat
    public let compositionGridLineOpacity: CGFloat
    public let compositionGridLineWidth: CGFloat
    public let toolbarBackground: Color
    public let toolbarChromeInset: CGFloat
    public let toolbarActionSpacing: CGFloat
    public let toolbarVerticalPadding: CGFloat
    public let toolbarHorizontalPadding: CGFloat
    public let cropRegionHorizontalInset: CGFloat
    public let cropRegionVerticalInset: CGFloat
    public let minimumCropRegionSide: CGFloat
    public let maximumZoomScale: CGFloat
    public let fallbackLayoutWidth: CGFloat
    public let fallbackLayoutHeight: CGFloat

    public init(
        canvasBackground: Color? = nil,
        overlayDimmingOpacity: CGFloat = 0.55,
        cropBorderWidth: CGFloat = 1,
        compositionGridLineOpacity: CGFloat = 0.2,
        compositionGridLineWidth: CGFloat = 1,
        toolbarBackground: Color? = nil,
        toolbarChromeInset: CGFloat = 3,
        toolbarActionSpacing: CGFloat = HIGSpacing.md.rawValue,
        toolbarVerticalPadding: CGFloat = HIGSpacing.sm.rawValue,
        toolbarHorizontalPadding: CGFloat = HIGSpacing.lg.rawValue,
        cropRegionHorizontalInset: CGFloat = HIGSpacing.lg.rawValue,
        cropRegionVerticalInset: CGFloat = HIGSpacing.xxxl.rawValue,
        minimumCropRegionSide: CGFloat = 160,
        maximumZoomScale: CGFloat = 4,
        fallbackLayoutWidth: CGFloat = 390,
        fallbackLayoutHeight: CGFloat = 640
    ) {
        self.canvasBackground = canvasBackground ?? Color.black
        self.overlayDimmingOpacity = overlayDimmingOpacity
        self.cropBorderWidth = cropBorderWidth
        self.compositionGridLineOpacity = compositionGridLineOpacity
        self.compositionGridLineWidth = compositionGridLineWidth
        self.toolbarBackground = toolbarBackground ?? HIGPlatformColor.systemBackground
        self.toolbarChromeInset = toolbarChromeInset
        self.toolbarActionSpacing = toolbarActionSpacing
        self.toolbarVerticalPadding = toolbarVerticalPadding
        self.toolbarHorizontalPadding = toolbarHorizontalPadding
        self.cropRegionHorizontalInset = cropRegionHorizontalInset
        self.cropRegionVerticalInset = cropRegionVerticalInset
        self.minimumCropRegionSide = minimumCropRegionSide
        self.maximumZoomScale = maximumZoomScale
        self.fallbackLayoutWidth = fallbackLayoutWidth
        self.fallbackLayoutHeight = fallbackLayoutHeight
    }
}