import HIGTokensComponent
import Testing

@Test
func activityIndicatorTokensDefineScaleProgression() {
    let tokens = HIGSystemActivityIndicatorTokens()
    #expect(tokens.smallScale < tokens.mediumScale)
    #expect(tokens.mediumScale < tokens.largeScale)
}