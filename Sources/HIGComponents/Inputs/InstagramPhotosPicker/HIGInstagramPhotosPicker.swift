import HIGThemesContract
import SwiftUI

/// A HIG-aligned wrapper around [InstagramPhotosPicker](https://github.com/S-M-Technology-Ltd/InstagramPhotos) for photo-library selection.
public struct HIGInstagramPhotosPicker: View {
    @Binding private var selection: [HIGInstagramPhotosAsset]
    private let configuration: HIGInstagramPhotosPickerConfiguration
    private let onCancel: (() -> Void)?
    private let onFinish: ((HIGInstagramPhotosPickerFinishResult) -> Void)?

    @Environment(\.dismiss) private var dismiss
    @Environment(\.higTheme) private var theme

    public init(
        selection: Binding<[HIGInstagramPhotosAsset]>,
        configuration: HIGInstagramPhotosPickerConfiguration = .init(),
        onCancel: (() -> Void)? = nil,
        onFinish: ((HIGInstagramPhotosPickerFinishResult) -> Void)? = nil
    ) {
        _selection = selection
        self.configuration = configuration
        self.onCancel = onCancel
        self.onFinish = onFinish
    }

    public var body: some View {
        #if os(iOS)
        instagramPicker
        #else
        unsupportedPlatformView
        #endif
    }

    #if os(iOS)
    private var instagramPicker: some View {
        InstagramPhotosPickerBridge(
            selection: $selection,
            configuration: configuration.instagramConfiguration,
            onCancel: {
                onCancel?()
                dismiss()
            },
            onFinish: { result in
                onFinish?(result)
                dismiss()
            }
        )
        .tint(theme.colors.accent)
    }
    #endif

    private var unsupportedPlatformView: some View {
        ContentUnavailableView(
            "Photo Picker Unavailable",
            systemImage: "photo.on.rectangle.angled",
            description: Text("HIGInstagramPhotosPicker is available on iOS only.")
        )
        .padding()
    }
}

#if DEBUG
#Preview("HIGInstagramPhotosPicker") {
    @Previewable @State var selection: [HIGInstagramPhotosAsset] = []

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGInstagramPhotosPicker(selection: $selection)
    }
}
#endif