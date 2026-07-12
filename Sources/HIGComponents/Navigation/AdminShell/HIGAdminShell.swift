import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// An admin application shell that hosts navigation and detail content.
///
/// Inspired by Remark Admin layout shells. v1 provides ``HIGAdminShellStyle/sidebar``
/// (Remark **base**) with optional brand title, themed sidebar list, and padded detail.
/// Prefer ``HIGSidebar`` when you only need a plain split view without brand chrome.
public struct HIGAdminShell<Selection: Hashable & Sendable, Content: View>: View {
    private let style: HIGAdminShellStyle
    private let brandTitle: String?
    private let sidebarTitle: String
    @Binding private var selection: Selection?
    private let items: [HIGSidebarItem<Selection>]
    private let content: (Selection) -> Content

    @Environment(\.higTheme) private var theme

    /// Creates an admin shell.
    /// - Parameters:
    ///   - style: Shell layout family (currently ``HIGAdminShellStyle/sidebar``).
    ///   - brandTitle: Optional product name above the sidebar list.
    ///   - sidebarTitle: Navigation title for the sidebar column.
    ///   - selection: Bound selected destination.
    ///   - items: Sidebar destinations (reuse ``HIGSidebarItem``).
    ///   - content: Detail builder for the selected destination.
    public init(
        style: HIGAdminShellStyle = .sidebar,
        brandTitle: String? = nil,
        sidebarTitle: String = "Sections",
        selection: Binding<Selection?>,
        items: [HIGSidebarItem<Selection>],
        @ViewBuilder content: @escaping (Selection) -> Content
    ) {
        self.style = style
        self.brandTitle = brandTitle
        self.sidebarTitle = sidebarTitle
        _selection = selection
        self.items = items
        self.content = content
    }

    public var body: some View {
        let tokens = theme.adminShell

        switch style {
        case .sidebar:
            sidebarShell(tokens: tokens)
        }
    }

    @ViewBuilder
    private func sidebarShell(tokens: any HIGAdminShellTokens) -> some View {
        NavigationSplitView {
            sidebarColumn(tokens: tokens)
                .navigationTitle(sidebarTitle)
                #if os(iOS) || os(macOS) || os(visionOS)
                .navigationSplitViewColumnWidth(
                    min: tokens.sidebarMinWidth,
                    ideal: tokens.sidebarIdealWidth,
                    max: tokens.sidebarMaxWidth
                )
                #endif
        } detail: {
            detailColumn(tokens: tokens)
        }
        .background(theme.colors.backgroundPrimary)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(brandTitle ?? sidebarTitle)
    }

    @ViewBuilder
    private func sidebarColumn(tokens: any HIGAdminShellTokens) -> some View {
        let sidebarTokens = theme.sidebar

        VStack(alignment: .leading, spacing: 0) {
            if let brandTitle {
                Text(brandTitle)
                    .font(tokens.brandFont)
                    .foregroundStyle(theme.colors.labelPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(tokens.brandPadding)
                    .accessibilityAddTraits(.isHeader)

                HIGDivider()
            }

            styledSidebarList(sidebarTokens: sidebarTokens)
        }
        .background(theme.colors.backgroundPrimary)
    }

    @ViewBuilder
    private func styledSidebarList(sidebarTokens: any HIGSidebarTokens) -> some View {
        #if os(iOS) || os(visionOS) || os(macOS)
        List(items, selection: $selection) { item in
            Label(item.title, systemImage: item.systemImage)
                .tag(Optional(item.id))
                .padding(.vertical, sidebarTokens.rowPadding)
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

    @ViewBuilder
    private func detailColumn(tokens: any HIGAdminShellTokens) -> some View {
        Group {
            if let selection {
                content(selection)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(tokens.contentPadding)
            } else {
                ContentUnavailableView(
                    "Select a Section",
                    systemImage: "sidebar.left",
                    description: Text("Choose an item from the sidebar.")
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.colors.backgroundPrimary)
    }
}

#if DEBUG
private enum HIGAdminShellPreviewSection: String, Hashable, Sendable {
    case dashboard
    case users
    case settings
}

#Preview("HIGAdminShell") {
    @Previewable @State var selection: HIGAdminShellPreviewSection? = .dashboard

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGAdminShell(
            brandTitle: "HIG Admin",
            sidebarTitle: "Menu",
            selection: $selection,
            items: [
                HIGSidebarItem(id: HIGAdminShellPreviewSection.dashboard, title: "Dashboard", systemImage: "square.grid.2x2"),
                HIGSidebarItem(id: HIGAdminShellPreviewSection.users, title: "Users", systemImage: "person.2"),
                HIGSidebarItem(id: HIGAdminShellPreviewSection.settings, title: "Settings", systemImage: "gearshape"),
            ]
        ) { section in
            VStack(alignment: .leading, spacing: HIGSpacing.sm.rawValue) {
                Text(section.rawValue.capitalized)
                    .font(.title2)
                Text("Detail content for \(section.rawValue).")
                    .foregroundStyle(.secondary)
            }
        }
    }
}
#endif

