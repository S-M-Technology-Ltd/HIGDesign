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
#endif