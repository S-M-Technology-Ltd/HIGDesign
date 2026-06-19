import HIGTokensComponent
import Testing

@Test
func cardTokensUseReadablePaddingAndRadius() {
    let tokens = HIGSystemCardTokens()
    #expect(tokens.contentPadding >= 12)
    #expect(tokens.cornerRadius >= 8)
    #expect(tokens.borderWidth > 0)
}