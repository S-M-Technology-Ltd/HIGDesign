import HIGTokensComponent
import Testing

@Test
func menuButtonTokensUseMinimumTouchHeight() {
    let tokens = HIGSystemMenuButtonTokens()
    #expect(tokens.minHeight >= 44)
    #expect(tokens.horizontalPadding > 0)
}

@Test
func tagTokensUsePillPadding() {
    let tokens = HIGSystemTagTokens()
    #expect(tokens.horizontalPadding >= 8)
    #expect(tokens.cornerRadius >= 12)
}

@Test
func navigationBarTokensDefineFonts() {
    let tokens = HIGSystemNavigationBarTokens()
    #expect(tokens.titleFont == .headline)
}

@Test
func toolbarTokensDefineActionFont() {
    let tokens = HIGSystemToolbarTokens()
    #expect(tokens.actionFont == .body)
}