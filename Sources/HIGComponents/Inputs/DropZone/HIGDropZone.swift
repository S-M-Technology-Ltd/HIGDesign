import HIGFoundations
import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import SwiftUI
import UniformTypeIdentifiers

/// A file browse and drop surface for admin upload flows.
///
/// Uses SwiftUI ``fileImporter`` and drag-and-drop where the platform supports them.
/// Selected file URLs are stored in ``urls``; callers own security-scoped access if needed.
public struct HIGDropZone: View {
    private let title: String
    private let message: String
    private let browseLabel: String
    private let allowedContentTypes: [UTType]
    private let allowsMultipleSelection: Bool
    @Binding private var urls: [URL]

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @State private var isTargeted = false
    @State private var showsImporter = false

    /// Creates a drop zone.
    /// - Parameters:
    ///   - title: Primary label inside the zone.
    ///   - urls: Bound list of selected file URLs.
    ///   - message: Secondary guidance under the title.
    ///   - browseLabel: Button title for the system file picker.
    ///   - allowedContentTypes: UTTypes accepted by browse and drop.
    ///   - allowsMultipleSelection: When `false`, replaces the selection with a single file.
    public init(
        _ title: String = "Drop files here",
        urls: Binding<[URL]>,
        message: String = "or browse to upload",
        browseLabel: String = "Choose Files",
        allowedContentTypes: [UTType] = [.item],
        allowsMultipleSelection: Bool = true
    ) {
        self.title = title
        _urls = urls
        self.message = message
        self.browseLabel = browseLabel
        self.allowedContentTypes = allowedContentTypes
        self.allowsMultipleSelection = allowsMultipleSelection
    }

    public var body: some View {
        let tokens = theme.dropZone
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget * 2)
        let rowHeight = max(tokens.fileRowMinHeight, capabilities.minimumTouchTarget)
        let borderColor = (isTargeted ? theme.colors.accent : theme.colors.separator)

        VStack(alignment: .leading, spacing: theme.spacing.item) {
            zone(tokens: tokens, minHeight: minHeight, borderColor: borderColor)

            if !urls.isEmpty {
                selectedFiles(tokens: tokens, rowHeight: rowHeight)
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(title)
        .accessibilityValue(urls.isEmpty ? message : "\(urls.count) files selected")
    }

    @ViewBuilder
    private func zone(
        tokens: any HIGDropZoneTokens,
        minHeight: CGFloat,
        borderColor: Color
    ) -> some View {
        VStack(spacing: tokens.stackSpacing) {
            Image(systemName: isTargeted ? "arrow.down.doc.fill" : "square.and.arrow.up")
                .font(.system(size: tokens.iconPointSize, weight: .regular))
                .foregroundStyle(isTargeted ? theme.colors.accent : theme.colors.labelSecondary)
                .accessibilityHidden(true)

            Text(title)
                .font(tokens.titleFont)
                .foregroundStyle(theme.colors.labelPrimary)
                .multilineTextAlignment(.center)

            Text(message)
                .font(tokens.messageFont)
                .foregroundStyle(theme.colors.labelSecondary)
                .multilineTextAlignment(.center)

            #if os(iOS) || os(macOS) || os(visionOS)
            Button(browseLabel) {
                showsImporter = true
            }
            .buttonStyle(.bordered)
            .disabled(!isEnabled)
            #endif
        }
        .frame(maxWidth: .infinity, minHeight: minHeight)
        .padding(tokens.contentPadding)
        .background(
            (isTargeted ? theme.colors.accent.opacity(theme.opacity.disabled) : theme.colors.backgroundSecondary)
        )
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(
                    borderColor,
                    style: StrokeStyle(
                        lineWidth: tokens.borderWidth,
                        dash: [tokens.dashLength, tokens.dashGap]
                    )
                )
        }
        #if os(iOS) || os(macOS) || os(visionOS)
        .fileImporter(
            isPresented: $showsImporter,
            allowedContentTypes: allowedContentTypes,
            allowsMultipleSelection: allowsMultipleSelection
        ) { result in
            handleImporterResult(result)
        }
        .dropDestination(for: URL.self) { items, _ in
            guard isEnabled else { return false }
            applySelection(items)
            return true
        } isTargeted: { targeted in
            isTargeted = targeted && isEnabled
        }
        #endif
    }

    private func selectedFiles(tokens: any HIGDropZoneTokens, rowHeight: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            ForEach(urls, id: \.self) { url in
                HStack(spacing: theme.spacing.compactItem) {
                    Image(systemName: "doc")
                        .foregroundStyle(theme.colors.labelSecondary)
                        .accessibilityHidden(true)

                    Text(url.lastPathComponent)
                        .font(tokens.messageFont)
                        .foregroundStyle(theme.colors.labelPrimary)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Button {
                        urls.removeAll { $0 == url }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(theme.colors.labelSecondary)
                            .frame(width: rowHeight, height: rowHeight)
                    }
                    .buttonStyle(.plain)
                    .disabled(!isEnabled)
                    .accessibilityLabel("Remove \(url.lastPathComponent)")
                }
                .frame(minHeight: rowHeight)
                .padding(.horizontal, tokens.contentPadding)
                .background(theme.colors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                        .strokeBorder(theme.colors.separator, lineWidth: theme.border.hairline)
                }
            }
        }
    }

    #if os(iOS) || os(macOS) || os(visionOS)
    private func handleImporterResult(_ result: Result<[URL], Error>) {
        switch result {
        case .success(let selected):
            applySelection(selected)
        case .failure(let error):
            HIGLogger.info("HIGDropZone fileImporter failed: \(error.localizedDescription)")
        }
    }
    #endif

    private func applySelection(_ selected: [URL]) {
        guard !selected.isEmpty else { return }
        if allowsMultipleSelection {
            let existing = Set(urls)
            let additions = selected.filter { !existing.contains($0) }
            urls.append(contentsOf: additions)
        } else if let first = selected.first {
            urls = [first]
        }
    }
}

#if DEBUG
#Preview("HIGDropZone") {
    @Previewable @State var urls: [URL] = []

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGDropZone(
            urls: $urls,
            allowedContentTypes: [.image, .pdf, .plainText]
        )
        .padding()
    }
}
#endif
