import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func fieldMessageTokensUseReadableMetrics() {
    let tokens = HIGSystemFieldMessageTokens()
    #expect(tokens.iconPointSize >= HIGSpacing.sm.rawValue)
    #expect(tokens.spacing >= HIGSpacing.xxs.rawValue)
}

@Test
func fieldMessageKindCasesAreStable() {
    #expect(HIGFieldMessageKind.allCases.count == 3)
}
