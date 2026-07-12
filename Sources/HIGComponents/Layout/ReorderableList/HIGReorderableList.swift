import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed list that supports drag-to-reorder of items.
///
/// Inspired by Remark Admin sortable lists. Uses native `List` + `onMove` so
/// reordering follows platform conventions. Metrics resolve from ``HIGTheme/reorderableList``.
public struct HIGReorderableList: View {
    @Binding private var items: [HIGReorderableListItem]
    private let caption: String?
    private let isReorderingEnabled: Bool

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a reorderable list.
    /// - Parameters:
    ///   - items: Bound item collection; reordered in place.
    ///   - caption: Optional helper text below the list (for example `"Drag to reorder"`).
    ///   - isReorderingEnabled: When `false`, rows are static.
    public init(
        items: Binding<[HIGReorderableListItem]>,
        caption: String? = "Drag to reorder",
        isReorderingEnabled: Bool = true
    ) {
        _items = items
        self.caption = caption
        self.isReorderingEnabled = isReorderingEnabled
    }

    public var body: some View {
        let tokens = theme.reorderableList
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.rowMinHeight, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: tokens.captionSpacing) {
            listContent(tokens: tokens, minHeight: minHeight)
                .frame(maxWidth: .infinity)
                .background(theme.colors.backgroundSecondary)
                .clipShape(
                    RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                        .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
                }
                .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)

            if let caption {
                Text(caption)
                    .font(tokens.captionFont)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Reorderable list")
        .accessibilityHint(isReorderingEnabled ? "Drag items to change order" : "")
    }

    @ViewBuilder
    private func listContent(tokens: any HIGReorderableListTokens, minHeight: CGFloat) -> some View {
        #if os(watchOS) || os(tvOS)
        // Compact platforms: static list; reordering is a host responsibility.
        VStack(alignment: .leading, spacing: 0) {
            ForEach(items) { item in
                row(item, tokens: tokens, minHeight: minHeight)
            }
        }
        #else
        List {
            ForEach(items) { item in
                row(item, tokens: tokens, minHeight: minHeight)
                    .listRowBackground(theme.colors.backgroundSecondary)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0,
                            leading: tokens.horizontalPadding,
                            bottom: 0,
                            trailing: tokens.horizontalPadding
                        )
                    )
            }
            .onMove { source, destination in
                guard isReorderingEnabled, isEnabled else { return }
                move(from: source, to: destination)
            }
        }
        .listStyle(.plain)
        #if os(iOS) || os(visionOS)
        .environment(\.editMode, .constant(isReorderingEnabled && isEnabled ? .active : .inactive))
        .scrollContentBackground(.hidden)
        #elseif os(macOS)
        .scrollContentBackground(.hidden)
        #endif
        #endif
    }

    private func row(
        _ item: HIGReorderableListItem,
        tokens: any HIGReorderableListTokens,
        minHeight: CGFloat
    ) -> some View {
        HStack(spacing: tokens.iconSpacing) {
            if let systemImage = item.systemImage {
                Image(systemName: systemImage)
                    .font(.system(size: tokens.rowIconPointSize, weight: .regular))
                    .foregroundStyle(theme.colors.labelSecondary)
                    .frame(width: tokens.rowIconPointSize + HIGSpacing.xxs.rawValue)
                    .accessibilityHidden(true)
            }
            Text(item.title)
                .font(tokens.titleFont)
                .foregroundStyle(theme.colors.labelPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .leading)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(item.title)
    }

    private func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
}

#if DEBUG
#Preview("HIGReorderableList") {
    struct HIGReorderableListPreviewHostView: View {
        @State private var items = [
            HIGReorderableListItem(id: "1", title: "Inbox", systemImage: "tray"),
            HIGReorderableListItem(id: "2", title: "Starred", systemImage: "star"),
            HIGReorderableListItem(id: "3", title: "Archive", systemImage: "archivebox"),
            HIGReorderableListItem(id: "4", title: "Trash", systemImage: "trash")
        ]

        var body: some View {
            HIGThemeableView(theme: HIGComponentPreviewTheme()) {
                HIGReorderableList(items: $items)
                    .frame(height: 280)
                    .padding()
            }
        }
    }

    return HIGReorderableListPreviewHostView()
}
#endif
