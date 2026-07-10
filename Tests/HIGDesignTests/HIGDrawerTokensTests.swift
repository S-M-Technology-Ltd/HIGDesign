import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func drawerTokensUseReadableMetrics() {
    let tokens = HIGSystemDrawerTokens()
    #expect(tokens.width >= 280)
    #expect(tokens.contentPadding >= HIGSpacing.md.rawValue)
    #expect(tokens.scrimOpacity > 0)
    #expect(tokens.borderWidth > 0)
}

@Test
func drawerEdgeCasesAreStable() {
    #expect(HIGDrawerEdge.allCases.count == 2)
}
