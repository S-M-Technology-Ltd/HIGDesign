import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed hierarchical tree for admin navigation and nested data.
///
/// Nodes expand and collapse via ``expandedIDs``. Optional ``selection`` highlights
/// a row. Inspired by Remark Admin tree views; chrome resolves from ``HIGTheme/treeView``.
public struct HIGTreeView: View {
    private let nodes: [HIGTreeNode]
    @Binding private var expandedIDs: Set<String>
    @Binding private var selection: String?

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a tree view.
    /// - Parameters:
    ///   - nodes: Root-level nodes.
    ///   - expandedIDs: Bound set of expanded node identifiers.
    ///   - selection: Optional bound selected node identifier.
    public init(
        nodes: [HIGTreeNode],
        expandedIDs: Binding<Set<String>>,
        selection: Binding<String?> = .constant(nil)
    ) {
        self.nodes = nodes
        _expandedIDs = expandedIDs
        _selection = selection
    }

    public var body: some View {
        let tokens = theme.treeView
        let shape = RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)

        VStack(alignment: .leading, spacing: 0) {
            ForEach(nodes) { node in
                HIGTreeNodeRowView(
                    node: node,
                    depth: 0,
                    expandedIDs: $expandedIDs,
                    selection: $selection
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.backgroundSecondary)
        .clipShape(shape)
        .overlay {
            shape.strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Tree")
    }
}

/// Recursive row renderer for ``HIGTreeView``.
private struct HIGTreeNodeRowView: View {
    let node: HIGTreeNode
    let depth: Int
    @Binding var expandedIDs: Set<String>
    @Binding var selection: String?

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    private var isExpanded: Bool {
        expandedIDs.contains(node.id)
    }

    private var isSelected: Bool {
        selection == node.id
    }

    var body: some View {
        let tokens = theme.treeView
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.rowMinHeight, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: tokens.iconSpacing) {
                Color.clear
                    .frame(width: tokens.indentWidth * CGFloat(depth))

                if node.isLeaf {
                    Color.clear
                        .frame(width: tokens.chevronPointSize)
                } else {
                    Button {
                        toggleExpanded()
                    } label: {
                        Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                            .font(.system(size: tokens.chevronPointSize, weight: .semibold))
                            .foregroundStyle(theme.colors.labelSecondary)
                            .frame(width: tokens.chevronPointSize + HIGSpacing.xxs.rawValue * 2,
                                   height: minHeight)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .disabled(!isEnabled)
                    .accessibilityLabel(isExpanded ? "Collapse \(node.title)" : "Expand \(node.title)")
                }

                Button {
                    selection = node.id
                } label: {
                    HStack(spacing: tokens.iconSpacing) {
                        if let systemImage = node.systemImage {
                            Image(systemName: systemImage)
                                .font(.system(size: tokens.rowIconPointSize, weight: .regular))
                                .foregroundStyle(isSelected ? theme.colors.accent : theme.colors.labelSecondary)
                                .frame(width: tokens.rowIconPointSize + HIGSpacing.xxs.rawValue)
                        }

                        Text(node.title)
                            .font(tokens.titleFont)
                            .foregroundStyle(isSelected ? theme.colors.accent : theme.colors.labelPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .leading)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .disabled(!isEnabled)
                .accessibilityLabel(node.title)
                .accessibilityAddTraits(isSelected ? .isSelected : [])
            }
            .padding(.horizontal, tokens.horizontalPadding)
            .background(isSelected ? theme.colors.fillPrimary : Color.clear)

            if isExpanded, !node.isLeaf {
                ForEach(node.children) { child in
                    HIGTreeNodeRowView(
                        node: child,
                        depth: depth + 1,
                        expandedIDs: $expandedIDs,
                        selection: $selection
                    )
                }
            }
        }
    }

    private func toggleExpanded() {
        if isExpanded {
            expandedIDs.remove(node.id)
        } else {
            expandedIDs.insert(node.id)
        }
    }
}

#if DEBUG
#Preview("HIGTreeView") {
    struct HIGTreeViewPreviewHostView: View {
        @State private var expanded: Set<String> = ["docs", "guides"]
        @State private var selection: String? = "intro"

        var body: some View {
            HIGThemeableView(theme: HIGComponentPreviewTheme()) {
                HIGTreeView(
                    nodes: [
                        HIGTreeNode(
                            id: "docs",
                            title: "Documentation",
                            systemImage: "folder",
                            children: [
                                HIGTreeNode(id: "intro", title: "Introduction", systemImage: "doc.text"),
                                HIGTreeNode(
                                    id: "guides",
                                    title: "Guides",
                                    systemImage: "folder",
                                    children: [
                                        HIGTreeNode(id: "tokens", title: "Tokens", systemImage: "doc.text"),
                                        HIGTreeNode(id: "themes", title: "Themes", systemImage: "doc.text")
                                    ]
                                )
                            ]
                        ),
                        HIGTreeNode(id: "settings", title: "Settings", systemImage: "gearshape")
                    ],
                    expandedIDs: $expanded,
                    selection: $selection
                )
                .padding()
            }
        }
    }

    return HIGTreeViewPreviewHostView()
}
#endif
