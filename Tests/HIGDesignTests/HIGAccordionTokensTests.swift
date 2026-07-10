import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func accordionTokensUseReadableMetrics() {
    let tokens = HIGSystemAccordionTokens()
    #expect(tokens.headerMinHeight >= 44)
    #expect(tokens.contentPadding >= HIGSpacing.sm.rawValue)
    #expect(tokens.sectionSpacing >= HIGSpacing.xs.rawValue)
    #expect(tokens.borderWidth > 0)
}
