#if os(iOS)
import HIGDesign
import SwiftUI

struct ShowcasePhotoPickerView: View {
    @Environment(\.higTheme) private var theme
    @State private var isPickerPresented = false
    @State private var isEditorPresented = false
    @State private var selection: [HIGPhotoAsset] = []
    @State private var selectedImage: CGImage?
    @State private var isLoadingImage = false
    @State private var statusMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .photoPicker)

                if let selectedImage {
                    ShowcaseSampleView(code: """
                    HIGPhotoEditor(
                        image: selectedImage,
                        configuration: .init(aspectRatio: .square),
                        onFinish: { result in ... }
                    )
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
                            Image(decorative: selectedImage, scale: 1, orientation: .up)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 240)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: theme.card.cornerRadius,
                                        style: .continuous
                                    )
                                )

                            Text("\(selection.count) asset(s) selected")
                                .font(theme.typography.headline)

                            HIGButton("Edit Photo", systemImage: "crop", role: .secondary, style: .glass) {
                                isEditorPresented = true
                            }
                        }
                    }
                } else if selection.isEmpty {
                    ShowcaseSampleView(code: """
                    ContentUnavailableView(
                        "No Photos Selected",
                        systemImage: "photo.on.rectangle.angled",
                        description: Text("Present the picker to choose images.")
                    )
                    """) {
                        ContentUnavailableView(
                            "No Photos Selected",
                            systemImage: "photo.on.rectangle.angled",
                            description: Text("Present the picker to choose images from the photo library.")
                        )
                        .frame(maxWidth: .infinity)
                    }
                } else {
                    ShowcaseSampleView(code: "// Loading full-size image for photo editor") {
                        VStack(spacing: theme.spacing.compactItem) {
                            ProgressView()
                            Text("Loading selected photo…")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }

                if let statusMessage {
                    Text(statusMessage)
                        .font(theme.typography.caption)
                        .foregroundStyle(theme.colors.labelSecondary)
                }

                ShowcaseSampleView(code: """
                HIGButton("Pick Photos", role: .primary) { isPickerPresented = true }
                .sheet(isPresented: $isPickerPresented) {
                    HIGPhotoPicker(
                        selection: $selection,
                        configuration: .init(
                            selectionLimit: 10,
                            allowsMultipleSelection: true,
                            automaticallyRequestsPhotoAccess: false
                        ),
                        onFinish: { result in ... }
                    )
                }
                """) {
                    HIGButton("Pick Photos", role: .primary) {
                        isPickerPresented = true
                    }
                    .disabled(isLoadingImage)
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Photo Picker")
        .sheet(isPresented: $isPickerPresented) {
            HIGPhotoPicker(
                selection: $selection,
                configuration: .init(
                    selectionLimit: 10,
                    allowsMultipleSelection: true,
                    automaticallyRequestsPhotoAccess: false
                ),
                onFinish: { result in
                    statusMessage = "Finished with \(result.assets.count) photo(s)"
                    loadFirstSelectedImage(from: result)
                }
            )
        }
        .sheet(isPresented: $isEditorPresented) {
            if let selectedImage {
                HIGPhotoEditor(
                    image: selectedImage,
                    configuration: .init(aspectRatio: .square),
                    onFinish: { result in
                        statusMessage = "Edited to \(result.croppedImage.width)×\(result.croppedImage.height) px"
                    }
                )
            }
        }
    }

    private func loadFirstSelectedImage(from result: HIGPhotoPickerFinishResult? = nil) {
        let assets = result?.assets ?? selection
        guard let asset = assets.first else {
            selectedImage = nil
            return
        }

        isLoadingImage = true
        selectedImage = nil

        Task {
            defer { isLoadingImage = false }

            do {
                let images = try await [asset].loadImages(
                    configuration: .init(iCloudNetworkAccessAllowed: true)
                )
                selectedImage = images.first?.cgImage
            } catch {
                statusMessage = "Could not load the selected photo for editing."
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePhotoPickerView") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        NavigationStack {
            ShowcasePhotoPickerView()
        }
    }
}
#endif
#else
import HIGDesign
import SwiftUI

struct ShowcasePhotoPickerView: View {
    @Environment(\.higTheme) private var theme
    @State private var isPickerPresented = false
    @State private var selection: [HIGPhotoAsset] = []
    @State private var statusMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .photoPicker)

                if selection.isEmpty {
                    ShowcaseSampleView(code: """
                    ContentUnavailableView(
                        "No Photos Selected",
                        systemImage: "photo.on.rectangle.angled",
                        description: Text("Present the picker to choose images.")
                    )
                    """) {
                        ContentUnavailableView(
                            "No Photos Selected",
                            systemImage: "photo.on.rectangle.angled",
                            description: Text("Present the picker to choose images from the photo library.")
                        )
                        .frame(maxWidth: .infinity)
                    }
                } else {
                    ShowcaseSampleView(code: "// \(selection.count) HIGPhotoAsset(s) in selection") {
                        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
                            Text("\(selection.count) asset(s) selected")
                                .font(theme.typography.headline)
                            ForEach(selection) { asset in
                                Text(asset.id)
                                    .font(theme.typography.caption.monospaced())
                                    .foregroundStyle(theme.colors.labelSecondary)
                                    .lineLimit(1)
                            }
                        }
                    }
                }

                if let statusMessage {
                    Text(statusMessage)
                        .font(theme.typography.caption)
                        .foregroundStyle(theme.colors.labelSecondary)
                }

                ShowcaseSampleView(code: """
                HIGButton("Pick Photos", role: .primary) { isPickerPresented = true }
                """) {
                    HIGButton("Pick Photos", role: .primary) {
                        isPickerPresented = true
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Photo Picker")
    }
}
#endif