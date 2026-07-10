import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func stepsTokensUseReadableMetrics() {
    let tokens = HIGSystemStepsTokens()
    #expect(tokens.indicatorSize >= HIGSpacing.lg.rawValue)
    #expect(tokens.minTapTarget >= 44)
    #expect(tokens.itemSpacing >= HIGSpacing.xs.rawValue)
}

@Test
func stepsItemUsesTitleAsDefaultIdentifier() {
    let item = HIGStepsItem("Shipping", detail: "Address")
    #expect(item.id == "Shipping")
    #expect(item.title == "Shipping")
    #expect(item.detail == "Address")
}

@Test
func stepsAxisCasesAreStable() {
    #expect(HIGStepsAxis.allCases.count == 2)
}
