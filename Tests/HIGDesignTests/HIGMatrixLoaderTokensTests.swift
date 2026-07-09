import HIGTokensComponent
import Testing

@Test
func matrixLoaderTokensDefineSizeProgression() {
    let tokens = HIGSystemMatrixLoaderTokens()
    #expect(tokens.smallDiameter < tokens.mediumDiameter)
    #expect(tokens.mediumDiameter < tokens.largeDiameter)
    #expect(tokens.gridCount >= 3)
    #expect(tokens.gapFraction > 0)
    #expect(tokens.gapFraction < 1)
    #expect(tokens.baseOpacity < tokens.peakOpacity)
    #expect(tokens.cycleDurationMultiplier > 0)
}
