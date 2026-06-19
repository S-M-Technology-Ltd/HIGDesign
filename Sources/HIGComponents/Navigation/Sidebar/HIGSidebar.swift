import HIGThemesContract
import SwiftUI

/// A sidebar navigation container built on `NavigationSplitView`.
public struct HIGSidebar<Selection: Hashable & Sendable, Detail: View>: View {
    @Binding private var selection: Selection?
    private let title: String
    private let items: [HIGSidebarItem<Selection>]
    private let detail: (Selection) -> Detail

    @Environment(\.higTheme) private var theme

    public init(
        selection: Binding<Selection?>,
        title: String = "Sections",
        items: [HIGSidebarItem<Selection>],
        @ViewBuilder detail: @escaping (Selection) -> Detail
    ) {
        _selection = selection
        self.title = title
        self.items = items
        self.detail = detail
    }

    public var body: some View {
        NavigationSplitView {
            styledSidebarList
                .navigationTitle(title)
        } detail: {
            if let selection {
                detail(selection)
            } else {
                ContentUnavailableView(
                    "Select a Section",
                    systemImage: "sidebar.left",
                    description: Text("Choose an item from the sidebar.")
                )
            }
        }
    }

    @ViewBuilder
    private var styledSidebarList: some View {
        let tokens = theme.sidebar

        #if os(iOS) || os(visionOS) || os(macOS)
        List(items, selection: $selection) { item in
            Label(item.title, systemImage: item.systemImage)
                .tag(Optional(item.id))
                .padding(.vertical, tokens.rowPadding)
                .listRowBackground(theme.colors.backgroundSecondary)
        }
        .listStyle(.sidebar)
        .scrollContentBackground(.hidden)
        .background(theme.colors.backgroundPrimary)
        #else
        List(items, selection: $selection) { item in
            Label(item.title, systemImage: item.systemImage)
                .tag(Optional(item.id))
        }
        #endif
    }
}

#if DEBUG
private enum HIGSidebarPreviewSection: String, Hashable, Sendable {
    case inbox
    case drafts
}

#Preview("HIGSidebar") {
    @Previewable @State var selection: HIGSidebarPreviewSection? = .inbox

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGSidebar(
            selection: $selection,
            title: "Mail",
            items: [
                HIGSidebarItem(id: HIGSidebarPreviewSection.inbox, title: "Inbox", systemImage: "tray"),
                HIGSidebarItem(id: HIGSidebarPreviewSection.drafts, title: "Drafts", systemImage: "doc"),
            ]
        ) { section in
            Text(section == .inbox ? "Inbox" : "Drafts")
                .font(.title2)
                .padding()
        }
    }
}
#endif