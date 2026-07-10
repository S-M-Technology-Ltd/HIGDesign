import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func tabsTokensUseReadableMetrics() {
    let tokens = HIGSystemTabsTokens()
    #expect(tokens.minTapTarget >= 44)
    #expect(tokens.itemSpacing >= HIGSpacing.sm.rawValue)
    #expect(tokens.underlineHeight > 0)
}

@Test
func tabsItemUsesTitleAsDefaultIdentifier() {
    let item = HIGTabsItem("Profile")
    #expect(item.id == "Profile")
    #expect(item.title == "Profile")
}
