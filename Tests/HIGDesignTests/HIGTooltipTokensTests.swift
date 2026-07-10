import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func tooltipTokensUseReadableMetrics() {
    let tokens = HIGSystemTooltipTokens()
    #expect(tokens.horizontalPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.verticalPadding >= HIGSpacing.xxs.rawValue)
    #expect(tokens.maxWidth >= 160)
    #expect(tokens.cornerRadius >= HIGRadius.sm.rawValue)
}
