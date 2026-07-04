#if os(iOS)
import Foundation

/// The shape of the crop region, matching ``TOCropViewController`` cropping styles.
public enum HIGPhotoEditorCroppingStyle: String, Sendable, Equatable, CaseIterable {
    case `default`
    case circular
}
#endif