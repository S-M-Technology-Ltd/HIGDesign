import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func pageHeaderTokensUseReadableSpacing() {
    let tokens = HIGSystemPageHeaderTokens()
    #expect(tokens.stackSpacing >= HIGSpacing.xs.rawValue)
    #expect(tokens.breadcrumbSpacing >= HIGSpacing.sm.rawValue)
}

@Test
func pageHeaderTokensAcceptDenseOverrides() {
    let tokens = HIGSystemPageHeaderTokens(
        stackSpacing: HIGSpacing.xxs.rawValue,
        breadcrumbSpacing: HIGSpacing.sm.rawValue
    )
    #expect(tokens.stackSpacing == HIGSpacing.xxs.rawValue)
    #expect(tokens.breadcrumbSpacing == HIGSpacing.sm.rawValue)
}
