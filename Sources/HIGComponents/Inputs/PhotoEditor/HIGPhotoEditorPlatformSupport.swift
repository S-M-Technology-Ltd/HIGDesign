#if !os(iOS)
import CoreGraphics
import SwiftUI

/// The shape of the crop region for ``HIGPhotoEditor``.
public enum HIGPhotoEditorCroppingStyle: String, Sendable, Equatable, CaseIterable {
    case `default`
    case circular
}

/// Aspect ratio presets for ``HIGPhotoEditor``.
public enum HIGPhotoEditorAspectRatio: String, Sendable, Equatable, CaseIterable, Identifiable {
    case original
    case square
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
        case .ratio3x2: 3 / 2
        case .ratio5x3: 5 / 3
        case .ratio4x3: 4 / 3
        case .ratio5x4: 5 / 4
        case .ratio7x5: 7 / 5
        case .ratio16x9: 16 / 9
        }
    }

    public func resolvedAspect(for imageSize: CGSize) -> CGFloat {
        if let presetAspect {
            return presetAspect
        }
        guard imageSize.width > 0, imageSize.height > 0 else { return 1 }
        return imageSize.width / imageSize.height
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

    public init(
        croppedImage: CGImage,
        cropRect: CGRect,
        angle: Int,
        croppingStyle: HIGPhotoEditorCroppingStyle,
        aspectRatio: HIGPhotoEditorAspectRatio
    ) {
        self.croppedImage = croppedImage
        self.cropRect = cropRect
        self.angle = HIGPhotoEditorCropState.normalizedAngle(angle)
        self.croppingStyle = croppingStyle
        self.aspectRatio = aspectRatio
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

    public init(
        title: String = "Edit Photo",
        cancelTitle: String = "Cancel",
        doneTitle: String = "Done",
        resetTitle: String = "Reset",
        rotateTitle: String = "Rotate",
        aspectRatioTitle: String = "Aspect Ratio"
    ) {
        self.title = title
        self.cancelTitle = cancelTitle
        self.doneTitle = doneTitle
        self.resetTitle = resetTitle
        self.rotateTitle = rotateTitle
        self.aspectRatioTitle = aspectRatioTitle
    }
}

/// Configuration for ``HIGPhotoEditor``.
public struct HIGPhotoEditorConfiguration: Equatable, Sendable {
    public var croppingStyle: HIGPhotoEditorCroppingStyle
    public var aspectRatio: HIGPhotoEditorAspectRatio
    public var toolbarPosition: HIGPhotoEditorToolbarPosition
    public var allowsAspectRatioSelection: Bool
    public var allowsRotation: Bool
    public var showsResetButton: Bool
    public var showsCompositionGridWhileInteracting: Bool
    public var localization: HIGPhotoEditorLocalization
    public var initialCropState: HIGPhotoEditorCropState?

    public init(
        croppingStyle: HIGPhotoEditorCroppingStyle = .default,
        aspectRatio: HIGPhotoEditorAspectRatio = .original,
        toolbarPosition: HIGPhotoEditorToolbarPosition = .bottom,
        allowsAspectRatioSelection: Bool = true,
        allowsRotation: Bool = true,
        showsResetButton: Bool = true,
        showsCompositionGridWhileInteracting: Bool = true,
        localization: HIGPhotoEditorLocalization = .init(),
        initialCropState: HIGPhotoEditorCropState? = nil
    ) {
        self.croppingStyle = croppingStyle
        self.aspectRatio = aspectRatio
        self.toolbarPosition = toolbarPosition
        self.allowsAspectRatioSelection = allowsAspectRatioSelection
        self.allowsRotation = allowsRotation
        self.showsResetButton = showsResetButton
        self.showsCompositionGridWhileInteracting = showsCompositionGridWhileInteracting
        self.localization = localization
        self.initialCropState = initialCropState
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