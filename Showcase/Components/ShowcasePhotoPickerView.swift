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
                }
            )
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