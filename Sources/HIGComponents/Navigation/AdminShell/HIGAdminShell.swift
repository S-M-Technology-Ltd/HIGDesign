import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// An admin application shell that hosts navigation and detail content.
///
/// Inspired by Remark Admin layout shells. Supports:
/// - ``HIGAdminShellStyle/sidebar`` — Remark **base** (labeled sidebar list)
/// - ``HIGAdminShellStyle/iconRail`` — Remark **iconbar** (icon-only leading rail)
/// - ``HIGAdminShellStyle/topBar`` — Remark **topbar** (horizontal labeled nav strip)
/// - ``HIGAdminShellStyle/topIcon`` — Remark **topicon** (horizontal icon-only nav strip)
/// - ``HIGAdminShellStyle/centered`` — Remark **center** (top nav + max-width centered detail)
///
/// Prefer ``HIGSidebar`` when you only need a plain split view without brand chrome.
public struct HIGAdminShell<Selection: Hashable & Sendable, Content: View>: View {
    private let style: HIGAdminShellStyle
    private let brandTitle: String?
    private let sidebarTitle: String
    @Binding private var selection: Selection?
    private let items: [HIGSidebarItem<Selection>]
    private let content: (Selection) -> Content

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates an admin shell.
    /// - Parameters:
    ///   - style: Shell layout family (``.sidebar``, ``.iconRail``, ``.topBar``, ``.topIcon``, or ``.centered``).
    ///   - brandTitle: Optional product name in the navigation chrome.
    ///   - sidebarTitle: Navigation title for the leading column (sidebar / icon rail).
    ///   - selection: Bound selected destination.
    ///   - items: Navigation destinations (reuse ``HIGSidebarItem``).
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
        case .iconRail:
            iconRailShell(tokens: tokens)
        case .topBar:
            topStripShell(tokens: tokens, iconOnly: false)
        case .topIcon:
            topStripShell(tokens: tokens, iconOnly: true)
        case .centered:
            centeredShell(tokens: tokens)
        }
    }

    // MARK: - Sidebar (Remark base)

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

    // MARK: - Icon rail (Remark iconbar)

    @ViewBuilder
    private func iconRailShell(tokens: any HIGAdminShellTokens) -> some View {
        NavigationSplitView {
            iconRailColumn(tokens: tokens)
                .navigationTitle(sidebarTitle)
                #if os(iOS) || os(macOS) || os(visionOS)
                .navigationSplitViewColumnWidth(
                    min: tokens.iconRailWidth,
                    ideal: tokens.iconRailWidth,
                    max: tokens.iconRailWidth
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
    private func iconRailColumn(tokens: any HIGAdminShellTokens) -> some View {
        let capabilities = HIGPlatformCapabilities.current
        let minTarget = max(tokens.iconRailWidth - tokens.brandPadding, capabilities.minimumTouchTarget)

        VStack(spacing: tokens.iconRailItemSpacing) {
            if let brandTitle {
                Text(String(brandTitle.prefix(1)).uppercased())
                    .font(tokens.brandFont)
                    .foregroundStyle(theme.colors.labelPrimary)
                    .frame(width: minTarget, height: minTarget)
                    .background(theme.colors.backgroundSecondary)
                    .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))
                    .accessibilityLabel(brandTitle)
                    .accessibilityAddTraits(.isHeader)
                    .padding(.top, tokens.brandPadding)
            }

            ForEach(items) { item in
                Button {
                    selection = item.id
                } label: {
                    Image(systemName: item.systemImage)
                        .font(.system(size: tokens.iconRailIconPointSize, weight: .medium))
                        .foregroundStyle(item.id == selection ? theme.colors.accent : theme.colors.labelSecondary)
                        .frame(width: minTarget, height: minTarget)
                        .background(
                            item.id == selection
                                ? theme.colors.accent.opacity(theme.opacity.subtleFill)
                                : Color.clear
                        )
                        .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .disabled(!isEnabled)
                .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
                .accessibilityLabel(item.title)
                .accessibilityAddTraits(item.id == selection ? [.isButton, .isSelected] : .isButton)
            }

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, tokens.brandPadding)
        .background(theme.colors.backgroundPrimary)
    }

    // MARK: - Top strip (Remark topbar / topicon)

    @ViewBuilder
    private func topStripShell(tokens: any HIGAdminShellTokens, iconOnly: Bool) -> some View {
        VStack(spacing: 0) {
            topStrip(tokens: tokens, iconOnly: iconOnly)
            HIGDivider()
            detailColumn(tokens: tokens)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.colors.backgroundPrimary)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(brandTitle ?? sidebarTitle)
    }

    @ViewBuilder
    private func topStrip(tokens: any HIGAdminShellTokens, iconOnly: Bool) -> some View {
        let capabilities = HIGPlatformCapabilities.current
        let minTarget = max(tokens.topBarMinHeight, capabilities.minimumTouchTarget)
        let iconSize = iconOnly ? tokens.iconRailIconPointSize : tokens.topBarIconPointSize

        HStack(spacing: tokens.topBarItemSpacing) {
            if let brandTitle {
                if iconOnly {
                    Text(String(brandTitle.prefix(1)).uppercased())
                        .font(tokens.brandFont)
                        .foregroundStyle(theme.colors.labelPrimary)
                        .frame(width: minTarget, height: minTarget)
                        .background(theme.colors.backgroundPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))
                        .accessibilityLabel(brandTitle)
                        .accessibilityAddTraits(.isHeader)
                } else {
                    Text(brandTitle)
                        .font(tokens.brandFont)
                        .foregroundStyle(theme.colors.labelPrimary)
                        .lineLimit(1)
                        .accessibilityAddTraits(.isHeader)
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: tokens.topBarItemSpacing) {
                    ForEach(items) { item in
                        Button {
                            selection = item.id
                        } label: {
                            Group {
                                if iconOnly {
                                    Image(systemName: item.systemImage)
                                        .font(.system(size: iconSize, weight: .medium))
                                        .frame(width: minTarget, height: minTarget)
                                } else {
                                    Label {
                                        Text(item.title)
                                            .font(theme.typography.callout)
                                            .lineLimit(1)
                                    } icon: {
                                        Image(systemName: item.systemImage)
                                            .font(.system(size: iconSize, weight: .medium))
                                    }
                                    .labelStyle(.titleAndIcon)
                                    .padding(.horizontal, tokens.brandPadding)
                                    .frame(minHeight: minTarget)
                                }
                            }
                            .foregroundStyle(item.id == selection ? theme.colors.accent : theme.colors.labelSecondary)
                            .background(
                                item.id == selection
                                    ? theme.colors.accent.opacity(theme.opacity.subtleFill)
                                    : Color.clear
                            )
                            .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .disabled(!isEnabled)
                        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
                        .accessibilityLabel(item.title)
                        .accessibilityAddTraits(item.id == selection ? [.isButton, .isSelected] : .isButton)
                    }
                }
            }
        }
        .padding(.horizontal, tokens.brandPadding)
        .frame(maxWidth: .infinity, minHeight: minTarget, alignment: .leading)
        .background(theme.colors.backgroundSecondary)
    }

    // MARK: - Centered (Remark center)

    @ViewBuilder
    private func centeredShell(tokens: any HIGAdminShellTokens) -> some View {
        VStack(spacing: 0) {
            topStrip(tokens: tokens, iconOnly: false)
            HIGDivider()
            HStack(spacing: 0) {
                Spacer(minLength: 0)
                detailColumn(tokens: tokens)
                    .frame(maxWidth: tokens.centeredMaxWidth)
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(theme.colors.backgroundSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.colors.backgroundPrimary)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(brandTitle ?? sidebarTitle)
    }

    // MARK: - Detail

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
                    systemImage: emptyStateSystemImage,
                    description: Text(emptyStateDescription)
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.colors.backgroundPrimary)
    }

    private var emptyStateSystemImage: String {
        switch style {
        case .sidebar: "sidebar.left"
        case .iconRail: "rectangle.leftthird.inset.filled"
        case .topBar: "menubar.rectangle"
        case .topIcon: "rectangle.topthird.inset.filled"
        case .centered: "rectangle.center.inset.filled"
        }
    }

    private var emptyStateDescription: String {
        switch style {
        case .sidebar: "Choose an item from the sidebar."
        case .iconRail: "Choose an item from the icon rail."
        case .topBar: "Choose an item from the top bar."
        case .topIcon: "Choose an item from the top icon bar."
        case .centered: "Choose an item from the navigation bar."
        }
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

#Preview("HIGAdminShell — Icon Rail") {
    @Previewable @State var selection: HIGAdminShellPreviewSection? = .dashboard

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGAdminShell(
            style: .iconRail,
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
                Text("Icon rail detail for \(section.rawValue).")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview("HIGAdminShell — Top Bar") {
    @Previewable @State var selection: HIGAdminShellPreviewSection? = .dashboard

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGAdminShell(
            style: .topBar,
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
                Text("Top bar detail for \(section.rawValue).")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview("HIGAdminShell — Top Icon") {
    @Previewable @State var selection: HIGAdminShellPreviewSection? = .dashboard

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGAdminShell(
            style: .topIcon,
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
                Text("Top icon detail for \(section.rawValue).")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview("HIGAdminShell — Centered") {
    @Previewable @State var selection: HIGAdminShellPreviewSection? = .dashboard

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGAdminShell(
            style: .centered,
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
                Text("Centered detail for \(section.rawValue).")
                    .foregroundStyle(.secondary)
            }
        }
    }
}
#endif
