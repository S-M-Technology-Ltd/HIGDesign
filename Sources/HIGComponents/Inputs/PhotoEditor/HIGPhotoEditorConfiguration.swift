#if os(iOS)
import Foundation

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
#endif