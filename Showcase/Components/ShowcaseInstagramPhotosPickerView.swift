import HIGDesign
import SwiftUI

struct ShowcaseInstagramPhotosPickerView: View {
    @State private var isPickerPresented = false
    @State private var selection: [HIGInstagramPhotosAsset] = []
    @State private var statusMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .instagramPhotosPicker)

                if selection.isEmpty {
                    ContentUnavailableView(
                        "No Photos Selected",
                        systemImage: "photo.on.rectangle.angled",
                        description: Text("Present the picker to choose images from the photo library.")
                    )
                    .frame(maxWidth: .infinity)
                } else {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(selection.count) asset(s) selected")
                            .font(.headline)
                        ForEach(selection) { asset in
                            Text(asset.id)
                                .font(.caption.monospaced())
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }
                    }
                }

                if let statusMessage {
                    Text(statusMessage)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                HIGButton("Pick Photos", role: .primary) {
                    isPickerPresented = true
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Instagram Photos Picker")
        .sheet(isPresented: $isPickerPresented) {
            HIGInstagramPhotosPicker(
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
#Preview("ShowcaseInstagramPhotosPickerView") {
    NavigationStack {
        ShowcaseInstagramPhotosPickerView()
    }
}
#endif