import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func widgetTokensUseReadableMetrics() {
    let tokens = HIGSystemWidgetTokens()
    #expect(tokens.contentPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.minHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.stackSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.headerSpacing >= 0)
}
