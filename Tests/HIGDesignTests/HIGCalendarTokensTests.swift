import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func calendarTokensUseReadableMetrics() {
    let tokens = HIGSystemCalendarTokens()
    #expect(tokens.contentPadding >= HIGSpacing.sm.rawValue)
    #expect(tokens.dayMinSize >= HIGSpacing.md.rawValue)
    #expect(tokens.gridSpacing >= 0)
    #expect(tokens.markSize > 0)
    #expect(tokens.cornerRadius >= 0)
}
