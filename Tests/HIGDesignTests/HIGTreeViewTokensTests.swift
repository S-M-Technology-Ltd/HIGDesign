import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func treeViewTokensUseReadableMetrics() {
    let tokens = HIGSystemTreeViewTokens()
    #expect(tokens.rowMinHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.indentWidth >= HIGSpacing.sm.rawValue)
    #expect(tokens.chevronPointSize > 0)
    #expect(tokens.cornerRadius >= 0)
}

@Test
func treeNodeLeafDetectionWorks() {
    let leaf = HIGTreeNode(id: "a", title: "A")
    let parent = HIGTreeNode(
        id: "p",
        title: "Parent",
        children: [leaf]
    )
    #expect(leaf.isLeaf)
    #expect(!parent.isLeaf)
    #expect(parent.children.count == 1)
}
