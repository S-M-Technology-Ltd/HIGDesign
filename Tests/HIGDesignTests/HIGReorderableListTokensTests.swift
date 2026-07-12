import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func reorderableListTokensUseReadableMetrics() {
    let tokens = HIGSystemReorderableListTokens()
    #expect(tokens.rowMinHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.horizontalPadding >= HIGSpacing.xxs.rawValue)
    #expect(tokens.iconSpacing >= 0)
    #expect(tokens.cornerRadius >= 0)
}

@Test
func reorderableListItemPreservesIdentity() {
    let item = HIGReorderableListItem(id: "inbox", title: "Inbox", systemImage: "tray")
    #expect(item.id == "inbox")
    #expect(item.title == "Inbox")
    #expect(item.systemImage == "tray")
}
