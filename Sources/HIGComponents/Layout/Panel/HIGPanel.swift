import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// An admin-style content surface with optional title, description, actions, body, and footer.
///
/// Inspired by Remark Admin **panels** (title, actions, body, footer) but implemented as
/// HIG-native SwiftUI chrome that reads ``HIGTheme/panel`` tokens.
public struct HIGPanel<Content: View, Footer: View>: View {
    private let options: HIGPanelOptions
    private let isCollapsed: Binding<Bool>?
    private let actions: HIGPanelActions
    private let content: () -> Content
    private let footer: () -> Footer

    @Environment(\.higTheme) private var theme

    public init(
        _ options: HIGPanelOptions = HIGPanelOptions(),
        isCollapsed: Binding<Bool>? = nil,
        actions: HIGPanelActions = HIGPanelActions(),
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self.options = options
        self.isCollapsed = isCollapsed
        self.actions = actions
        self.content = content
        self.footer = footer
    }

    public var body: some View {
        let tokens = theme.panel
        let collapsed = isCollapsed?.wrappedValue ?? false

        VStack(alignment: .leading, spacing: tokens.headerSpacing) {
            if hasHeader {
                headerRow(tokens: tokens)
            }

            if !collapsed {
                content()
                    .frame(maxWidth: .infinity, alignment: .leading)

                footer()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(tokens.contentPadding)
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(options.title ?? "Panel")
        .accessibilityValue(collapsed ? "Collapsed" : "Expanded")
    }

    private var hasHeader: Bool {
        options.title != nil
            || options.description != nil
            || showsActionCluster
    }

    private var showsActionCluster: Bool {
        actions.onRefresh != nil
            || actions.onClose != nil
            || (options.showsCollapseControl && isCollapsed != nil)
    }

    @ViewBuilder
    private func headerRow(tokens: any HIGPanelTokens) -> some View {
        HStack(alignment: .top, spacing: theme.spacing.item) {
            VStack(alignment: .leading, spacing: tokens.headerSpacing) {
                if let title = options.title {
                    Text(title)
                        .font(tokens.titleFont)
                        .foregroundStyle(theme.colors.labelPrimary)
                        .accessibilityAddTraits(.isHeader)
                }
                if let description = options.description {
                    Text(description)
                        .font(tokens.descriptionFont)
                        .foregroundStyle(theme.colors.labelSecondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if showsActionCluster {
                actionCluster(tokens: tokens)
            }
        }
    }

    private func actionCluster(tokens: any HIGPanelTokens) -> some View {
        HStack(spacing: theme.spacing.compactItem) {
            if let onRefresh = actions.onRefresh {
                panelActionButton(
                    systemName: "arrow.clockwise",
                    label: "Refresh",
                    tokens: tokens,
                    action: onRefresh
                )
            }

            if options.showsCollapseControl, let isCollapsed {
                panelActionButton(
                    systemName: isCollapsed.wrappedValue ? "chevron.down" : "chevron.up",
                    label: isCollapsed.wrappedValue ? "Expand" : "Collapse",
                    tokens: tokens
                ) {
                    isCollapsed.wrappedValue.toggle()
                }
            }

            if let onClose = actions.onClose {
                panelActionButton(
                    systemName: "xmark",
                    label: "Close",
                    tokens: tokens,
                    action: onClose
                )
            }
        }
    }

    private func panelActionButton(
        systemName: String,
        label: String,
        tokens: any HIGPanelTokens,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: tokens.actionIconPointSize, weight: .semibold))
                .foregroundStyle(theme.colors.labelSecondary)
                .frame(width: tokens.minActionTarget, height: tokens.minActionTarget)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }
}

extension HIGPanel where Footer == EmptyView {
    /// Creates a panel without a footer.
    public init(
        _ options: HIGPanelOptions = HIGPanelOptions(),
        isCollapsed: Binding<Bool>? = nil,
        actions: HIGPanelActions = HIGPanelActions(),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            options,
            isCollapsed: isCollapsed,
            actions: actions,
            content: content,
            footer: { EmptyView() }
        )
    }

    /// Convenience initializer with a title string.
    public init(
        _ title: String,
        description: String? = nil,
        isCollapsed: Binding<Bool>? = nil,
        actions: HIGPanelActions = HIGPanelActions(),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            HIGPanelOptions(
                title: title,
                description: description,
                showsCollapseControl: isCollapsed != nil
            ),
            isCollapsed: isCollapsed,
            actions: actions,
            content: content,
            footer: { EmptyView() }
        )
    }
}

#if DEBUG
#Preview("HIGPanel — Basic") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGPanel("Overview", description: "Weekly summary") {
            Text("Panel body content uses theme tokens for chrome.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview("HIGPanel — Actions") {
    struct HIGPanelActionsPreviewHostView: View {
        @State private var collapsed = false
        @State private var refreshCount = 0

        var body: some View {
            HIGThemeableView(theme: HIGComponentPreviewTheme()) {
                HIGPanel(
                    HIGPanelOptions(
                        title: "Activity",
                        description: "Refreshed \(refreshCount) times",
                        showsCollapseControl: true
                    ),
                    isCollapsed: $collapsed,
                    actions: HIGPanelActions(
                        onRefresh: { refreshCount += 1 },
                        onClose: {}
                    )
                ) {
                    Text("Collapsible body")
                        .font(.body)
                } footer: {
                    Text("Footer")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
        }
    }

    return HIGPanelActionsPreviewHostView()
}
#endif
