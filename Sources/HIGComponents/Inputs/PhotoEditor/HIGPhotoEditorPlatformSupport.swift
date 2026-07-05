#if !os(iOS)
import CoreGraphics
import SwiftUI

/// The shape of the crop region for ``HIGPhotoEditor``.
public enum HIGPhotoEditorCroppingStyle: String, Sendable, Equatable, CaseIterable {
    case `default`
    case circular
}

/// Crop-frame orientation for ``HIGPhotoEditor`` aspect ratio presets.
public enum HIGPhotoEditorAspectRatioOrientation: String, Sendable, Equatable, CaseIterable, Identifiable {
    case landscape
    case portrait

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .landscape: "Landscape"
        case .portrait: "Portrait"
        }
    }
}

/// Aspect ratio presets for ``HIGPhotoEditor``.
public enum HIGPhotoEditorAspectRatio: String, Sendable, Equatable, CaseIterable, Identifiable {
    case original
    case square
    case landscape
    case portrait
    case ratio3x2
    case ratio5x3
    case ratio4x3
    case ratio5x4
    case ratio7x5
    case ratio16x9

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .original: "Original"
        case .square: "Square"
        case .landscape: "Landscape (16:9)"
        case .portrait: "Portrait (9:16)"
        case .ratio3x2: "3:2"
        case .ratio5x3: "5:3"
        case .ratio4x3: "4:3"
        case .ratio5x4: "5:4"
        case .ratio7x5: "7:5"
        case .ratio16x9: "16:9"
        }
    }

    public var presetAspect: CGFloat? {
        switch self {
        case .original: nil
        case .square: 1
        case .landscape: 16 / 9
        case .portrait: 9 / 16
        case .ratio3x2: 3 / 2
        case .ratio5x3: 5 / 3
        case .ratio4x3: 4 / 3
        case .ratio5x4: 5 / 4
        case .ratio7x5: 7 / 5
        case .ratio16x9: 16 / 9
        }
    }

    public func resolvedAspect(
        for imageSize: CGSize,
        orientation: HIGPhotoEditorAspectRatioOrientation = .landscape
    ) -> CGFloat {
        switch self {
        case .original:
            guard imageSize.width > 0, imageSize.height > 0 else { return 1 }
            let imageAspect = imageSize.width / imageSize.height
            switch orientation {
            case .landscape:
                return max(imageAspect, 1)
            case .portrait:
                return min(imageAspect, 1)
            }
        case .square:
            return 1
        case .landscape:
            return 16 / 9
        case .portrait:
            return 9 / 16
        default:
            guard let base = presetAspect else { return 1 }
            switch orientation {
            case .landscape:
                return base >= 1 ? base : 1 / base
            case .portrait:
                return base <= 1 ? base : 1 / base
            }
        }
    }
}

/// Placement of the editor toolbar.
public enum HIGPhotoEditorToolbarPosition: String, Sendable, Equatable {
    case bottom
    case top
}

/// Zoom, pan, rotation, and crop-region state for ``HIGPhotoEditor``.
public struct HIGPhotoEditorCropState: Equatable, Sendable {
    public var offsetX: CGFloat
    public var offsetY: CGFloat
    public var scale: CGFloat
    public var angle: Int
    public var cropRegionWidth: CGFloat
    public var cropRegionHeight: CGFloat

    public init(
        offsetX: CGFloat = 0,
        offsetY: CGFloat = 0,
        scale: CGFloat = 1,
        angle: Int = 0,
        cropRegionWidth: CGFloat = 0,
        cropRegionHeight: CGFloat = 0
    ) {
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.scale = Self.clampedScale(scale)
        self.angle = Self.normalizedAngle(angle)
        self.cropRegionWidth = cropRegionWidth
        self.cropRegionHeight = cropRegionHeight
    }

    public static let identity = HIGPhotoEditorCropState()

    public static let minimumScale: CGFloat = 1

    public static func clampedScale(_ scale: CGFloat, maximum: CGFloat = 4) -> CGFloat {
        min(max(scale, minimumScale), maximum)
    }

    public static func normalizedAngle(_ angle: Int) -> Int {
        let remainder = angle % 360
        return remainder < 0 ? remainder + 360 : remainder
    }
}

/// Cropped image and metadata returned when the editor finishes.
public struct HIGPhotoEditorFinishResult: Equatable, Sendable {
    public let croppedImage: CGImage
    public let cropRect: CGRect
    public let angle: Int
    public let croppingStyle: HIGPhotoEditorCroppingStyle
    public let aspectRatio: HIGPhotoEditorAspectRatio
    public let aspectRatioOrientation: HIGPhotoEditorAspectRatioOrientation

    public init(
        croppedImage: CGImage,
        cropRect: CGRect,
        angle: Int,
        croppingStyle: HIGPhotoEditorCroppingStyle,
        aspectRatio: HIGPhotoEditorAspectRatio,
        aspectRatioOrientation: HIGPhotoEditorAspectRatioOrientation
    ) {
        self.croppedImage = croppedImage
        self.cropRect = cropRect
        self.angle = HIGPhotoEditorCropState.normalizedAngle(angle)
        self.croppingStyle = croppingStyle
        self.aspectRatio = aspectRatio
        self.aspectRatioOrientation = aspectRatioOrientation
    }
}

/// Localized strings for ``HIGPhotoEditor``.
public struct HIGPhotoEditorLocalization: Equatable, Sendable {
    public var title: String
    public var cancelTitle: String
    public var doneTitle: String
    public var resetTitle: String
    public var rotateTitle: String
    public var aspectRatioTitle: String
    public var landscapeOrientationTitle: String
    public var portraitOrientationTitle: String

    public init(
        title: String = "Edit Photo",
        cancelTitle: String = "Cancel",
        doneTitle: String = "Done",
        resetTitle: String = "Reset",
        rotateTitle: String = "Rotate",
        aspectRatioTitle: String = "Aspect Ratio",
        landscapeOrientationTitle: String = "Landscape",
        portraitOrientationTitle: String = "Portrait"
    ) {
        self.title = title
        self.cancelTitle = cancelTitle
        self.doneTitle = doneTitle
        self.resetTitle = resetTitle
        self.rotateTitle = rotateTitle
        self.aspectRatioTitle = aspectRatioTitle
        self.landscapeOrientationTitle = landscapeOrientationTitle
        self.portraitOrientationTitle = portraitOrientationTitle
    }
}

/// Configuration for ``HIGPhotoEditor``.
public struct HIGPhotoEditorConfiguration: Equatable, Sendable {
    public var croppingStyle: HIGPhotoEditorCroppingStyle
    public var aspectRatio: HIGPhotoEditorAspectRatio
    public var toolbarPosition: HIGPhotoEditorToolbarPosition
    public var allowsAspectRatioSelection: Bool
    public var allowsAspectRatioOrientationToggle: Bool
    public var allowsRotation: Bool
    public var showsResetButton: Bool
    public var showsCompositionGridWhileInteracting: Bool
    public var localization: HIGPhotoEditorLocalization
    public var initialCropState: HIGPhotoEditorCropState?
    public var initialAspectRatioOrientation: HIGPhotoEditorAspectRatioOrientation?

    public init(
        croppingStyle: HIGPhotoEditorCroppingStyle = .default,
        aspectRatio: HIGPhotoEditorAspectRatio = .original,
        toolbarPosition: HIGPhotoEditorToolbarPosition = .bottom,
        allowsAspectRatioSelection: Bool = true,
        allowsAspectRatioOrientationToggle: Bool = true,
        allowsRotation: Bool = true,
        showsResetButton: Bool = true,
        showsCompositionGridWhileInteracting: Bool = true,
        localization: HIGPhotoEditorLocalization = .init(),
        initialCropState: HIGPhotoEditorCropState? = nil,
        initialAspectRatioOrientation: HIGPhotoEditorAspectRatioOrientation? = nil
    ) {
        self.croppingStyle = croppingStyle
        self.aspectRatio = aspectRatio
        self.toolbarPosition = toolbarPosition
        self.allowsAspectRatioSelection = allowsAspectRatioSelection
        self.allowsAspectRatioOrientationToggle = allowsAspectRatioOrientationToggle
        self.allowsRotation = allowsRotation
        self.showsResetButton = showsResetButton
        self.showsCompositionGridWhileInteracting = showsCompositionGridWhileInteracting
        self.localization = localization
        self.initialCropState = initialCropState
        self.initialAspectRatioOrientation = initialAspectRatioOrientation
    }

    public var effectiveAspectRatio: HIGPhotoEditorAspectRatio {
        croppingStyle == .circular ? .square : aspectRatio
    }
}

/// Photo crop editor (iOS only).
public struct HIGPhotoEditor: View {
    private let image: CGImage
    private let configuration: HIGPhotoEditorConfiguration
    private let onCancel: (() -> Void)?
    private let onFinish: ((HIGPhotoEditorFinishResult) -> Void)?

    public init(
        image: CGImage,
        configuration: HIGPhotoEditorConfiguration = .init(),
        onCancel: (() -> Void)? = nil,
        onFinish: ((HIGPhotoEditorFinishResult) -> Void)? = nil
    ) {
        self.image = image
        self.configuration = configuration
        self.onCancel = onCancel
        self.onFinish = onFinish
    }

    public var body: some View {
        ContentUnavailableView(
            "Photo Editor Unavailable",
            systemImage: "crop",
            description: Text("HIGPhotoEditor is available on iOS only.")
        )
        .padding()
    }
}
#endif