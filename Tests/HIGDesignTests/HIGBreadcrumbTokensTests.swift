import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func breadcrumbTokensUseReadableMetrics() {
    let tokens = HIGSystemBreadcrumbTokens()
    #expect(tokens.itemSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.separatorPointSize > 0)
    #expect(tokens.minTapTarget >= 44)
}

@Test
func breadcrumbItemUsesTitleAsDefaultIdentifier() {
    let item = HIGBreadcrumbItem("Home")
    #expect(item.id == "Home")
    #expect(item.title == "Home")
}
