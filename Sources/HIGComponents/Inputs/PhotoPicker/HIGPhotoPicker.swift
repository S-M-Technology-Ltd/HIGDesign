#if os(iOS)
import SwiftUI

/// SwiftUI photo picker with Instagram-style album browsing, preview, and iCloud support.
public struct HIGPhotoPicker: View {
    @Binding private var selection: [HIGPhotoAsset]
    private let configuration: HIGPhotoPickerConfiguration
    private let onCancel: (() -> Void)?
    private let onFinish: ((HIGPhotoPickerFinishResult) -> Void)?

    @Environment(\.dismiss) private var dismiss

    /// Creates a picker bound to a selected asset array.
    public init(
        selection: Binding<[HIGPhotoAsset]>,
        configuration: HIGPhotoPickerConfiguration = .init(),
        onCancel: (() -> Void)? = nil,
        onFinish: ((HIGPhotoPickerFinishResult) -> Void)? = nil
    ) {
        _selection = selection
        self.configuration = configuration
        self.onCancel = onCancel
        self.onFinish = onFinish
    }

    public var body: some View {
        PickerRootView(
            selection: $selection,
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
        .interactiveDismissDisabled(true)
    }
}

// MARK: - Selection object convenience

public extension HIGPhotoPicker {
    /// Creates a picker driven by an ``HIGPhotoPickerSelection`` observable object.
    init(
        selectionObject: HIGPhotoPickerSelection,
        configuration: HIGPhotoPickerConfiguration = .init(),
        onCancel: (() -> Void)? = nil,
        onFinish: ((HIGPhotoPickerFinishResult) -> Void)? = nil
    ) {
        self.init(
            selection: Binding(
                get: { selectionObject.assets },
                set: { selectionObject.replaceAll(with: $0) }
            ),
            configuration: configuration,
            onCancel: onCancel,
            onFinish: onFinish
        )
    }
}

#if DEBUG
#Preview("Authorized") {
    HIGPhotoPreviewHostFactory.pickerRoot(state: .authorized)
}

#Preview("Limited") {
    HIGPhotoPreviewHostFactory.pickerRoot(state: .limited)
}

#Preview("Denied") {
    HIGPhotoPreviewHostFactory.pickerRoot(state: .denied)
}
#endif
#endif
