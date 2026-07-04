#if os(iOS)
import HIGDesign
import SwiftUI

struct ShowcasePhotoEditorView: View {
    @Environment(\.higTheme) private var theme
    @State private var isEditorPresented = false
    @State private var statusMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .photoEditor)

                ShowcaseSampleView(code: """
                HIGButton("Edit Photo", role: .primary) { isEditorPresented = true }
                .sheet(isPresented: $isEditorPresented) {
                    HIGPhotoEditor(
                        image: cgImage,
                        configuration: .init(aspectRatio: .square),
                        onFinish: { result in ... }
                    )
                }
                """) {
                    HIGButton("Edit Photo", role: .primary) {
                        isEditorPresented = true
                    }
                }

                if let statusMessage {
                    Text(statusMessage)
                        .font(theme.typography.caption)
                        .foregroundStyle(theme.colors.labelSecondary)
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Photo Editor")
        .sheet(isPresented: $isEditorPresented) {
            if let image = ShowcasePhotoEditorPreviewImage.make() {
                HIGPhotoEditor(
                    image: image,
                    configuration: .init(aspectRatio: .square),
                    onFinish: { result in
                        statusMessage = "Cropped to \(result.croppedImage.width)×\(result.croppedImage.height) px"
                    }
                )
            }
        }
    }
}

private enum ShowcasePhotoEditorPreviewImage {
    static func make() -> CGImage? {
        let width = 900
        let height = 1200
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }

        context.setFillColor(red: 0.15, green: 0.55, blue: 0.85, alpha: 1)
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))
        context.setFillColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        context.fill(CGRect(x: 80, y: 200, width: width - 160, height: width - 160))
        return context.makeImage()
    }
}
#else
import HIGDesign
import SwiftUI

struct ShowcasePhotoEditorView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ContentUnavailableView(
            "Photo Editor",
            systemImage: "crop",
            description: Text("HIGPhotoEditor is available on iOS.")
        )
        .navigationTitle("Photo Editor")
        .higPadding(.screenEdge)
    }
}
#endif