import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func buttonGroupTokensUseReadableSpacing() {
    let tokens = HIGSystemButtonGroupTokens()
    #expect(tokens.spacing >= HIGSpacing.xs.rawValue)
}

@Test
func buttonGroupAxisCasesAreStable() {
    #expect(HIGButtonGroupAxis.allCases.count == 2)
}
