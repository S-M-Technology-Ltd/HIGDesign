import HIGTokensComponent
import Testing

@Test
func textEditorTokensUseMinimumHeight() {
    let tokens = HIGSystemTextEditorTokens()
    #expect(tokens.minHeight >= 44)
    #expect(tokens.borderWidth > 0)
}

@Test
func stepperTokensUseMinimumTouchHeight() {
    let tokens = HIGSystemStepperTokens()
    #expect(tokens.minHeight >= 44)
}