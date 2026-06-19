import HIGThemesContract
import SwiftUI

/// A themed wrapper around native `List` with HIG spacing defaults.
public struct HIGList<Data: RandomAccessCollection, RowContent: View>: View where Data.Element: Identifiable {
    private let data: Data
    private let rowContent: (Data.Element) -> RowContent

    @Environment(\.higTheme) private var theme

    public init(
        _ data: Data,
        @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent
    ) {
        self.data = data
        self.rowContent = rowContent
    }

    public var body: some View {
        styledList
            .background(theme.colors.backgroundPrimary)
    }

    @ViewBuilder
    private var styledList: some View {
        #if os(iOS) || os(visionOS) || os(macOS)
        listView
            .scrollContentBackground(.hidden)
        #else
        listView
        #endif
    }

    @ViewBuilder
    private var listView: some View {
        #if os(iOS) || os(visionOS)
        List(data) { element in
            rowContent(element)
                .listRowBackground(theme.colors.backgroundSecondary)
        }
        .listStyle(.insetGrouped)
        #elseif os(macOS)
        List(data) { element in
            rowContent(element)
                .listRowBackground(theme.colors.backgroundSecondary)
        }
        .listStyle(.inset)
        #else
        List(data) { element in
            rowContent(element)
        }
        #endif
    }
}

#if DEBUG
private struct HIGListPreviewItem: Identifiable {
    let id = UUID()
    let title: String
}

#Preview("HIGList") {
    let items = [
        HIGListPreviewItem(title: "Inbox"),
        HIGListPreviewItem(title: "Drafts"),
        HIGListPreviewItem(title: "Archive"),
    ]

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGList(items) { item in
            Text(item.title)
        }
    }
}
#endif