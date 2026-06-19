import HIGTokensComponent
import Testing

@Test
func listTokensUseReadableSpacing() {
    let tokens = HIGSystemListTokens()
    #expect(tokens.rowSpacing > 0)
    #expect(tokens.sectionSpacing >= tokens.rowSpacing)
}