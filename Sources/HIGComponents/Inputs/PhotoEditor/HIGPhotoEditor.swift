#if os(iOS)
import CoreGraphics
import SwiftUI

/// SwiftUI photo editor with crop, rotate, and aspect-ratio controls inspired by ``TOCropViewController``.
public struct HIGPhotoEditor: View {
    private let image: CGImage
    private let configuration: HIGPhotoEditorConfiguration
    private let onCancel: (() -> Void)?
    private let onFinish: ((HIGPhotoEditorFinishResult) -> Void)?

    @Environment(\.dismiss) private var dismiss

    /// Creates an editor for the supplied image.
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
        NavigationStack {
            PhotoEditorRootView(
                image: image,
                configuration: configuration,
                onCancel: {
                    onCancel?()
                    dismiss()
                },
                onFinish: { result in
                    onFinish?(result)
                    dismiss()
                }
            )
        }
        .interactiveDismissDisabled(true)
    }
}

#if DEBUG
#Preview("HIGPhotoEditor — Default") {
    HIGPhotoEditorPreviewHost.editor()
}

#Preview("HIGPhotoEditor — Circular") {
    HIGPhotoEditorPreviewHost.editor(
        configuration: .init(croppingStyle: .circular, aspectRatio: .square)
    )
}

#Preview("HIGPhotoEditor — Square Aspect") {
    HIGPhotoEditorPreviewHost.editor(
        configuration: .init(aspectRatio: .square)
    )
}
#endif
#endif