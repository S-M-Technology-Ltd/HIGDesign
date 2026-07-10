import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func closeButtonTokensUseMinimumTapTarget() {
    let tokens = HIGSystemCloseButtonTokens()
    #expect(tokens.minTapTarget >= 44)
    #expect(tokens.iconPointSize >= HIGSpacing.sm.rawValue)
}
