import HIGTokensComponent
import Testing

@Test
func toastTokensUseReadablePadding() {
    let tokens = HIGSystemToastTokens()
    #expect(tokens.horizontalPadding >= 12)
    #expect(tokens.verticalPadding >= 8)
}