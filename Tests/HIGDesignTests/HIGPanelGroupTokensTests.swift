import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func panelGroupTokensUseReadableMetrics() {
    let tokens = HIGSystemPanelGroupTokens()
    #expect(tokens.stackSpacing >= HIGSpacing.xs.rawValue)
    #expect(tokens.titleSpacing >= HIGSpacing.xxs.rawValue)
}
