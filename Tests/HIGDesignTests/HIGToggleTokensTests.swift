import HIGTokensComponent
import Testing

@Test
func toggleTokensUseMinimumTouchHeight() {
    let tokens = HIGSystemToggleTokens()
    #expect(tokens.minHeight >= 44)
}