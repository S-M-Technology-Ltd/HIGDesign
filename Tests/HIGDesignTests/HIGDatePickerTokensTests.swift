import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func datePickerTokensUseReadableMetrics() {
    let tokens = HIGSystemDatePickerTokens()
    #expect(tokens.minHeight >= HIGSpacing.md.rawValue)
}
