import HIGTokensComponent
import Testing

@Test
func activityIndicatorTokensDefineScaleProgression() {
    let tokens = HIGSystemActivityIndicatorTokens()
    #expect(tokens.smallScale < tokens.mediumScale)
    #expect(tokens.mediumScale < tokens.largeScale)
}

@Test
func activityIndicatorTokensDefineCustomStyleMetrics() {
    let tokens = HIGSystemActivityIndicatorTokens()
    #expect(tokens.customDiameter > 0)
    #expect(tokens.orbitalLineWidth > 0)
    #expect(tokens.pulsingSegmentCount > 0)
    #expect(tokens.pulsingDimmedOpacity > 0)
    #expect(tokens.pulsingDimmedOpacity < 1)
}