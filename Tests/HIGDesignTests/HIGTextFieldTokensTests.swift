import HIGTokensComponent
import Testing

@Test
func textFieldTokensUseMinimumTouchHeight() {
    let tokens = HIGSystemTextFieldTokens()
    #expect(tokens.minHeight >= 44)
    #expect(tokens.borderWidth > 0)
}