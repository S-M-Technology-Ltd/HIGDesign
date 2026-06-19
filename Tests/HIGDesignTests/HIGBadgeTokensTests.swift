import HIGTokensComponent
import Testing

@Test
func badgeTokensUseCompactPadding() {
    let tokens = HIGSystemBadgeTokens()
    #expect(tokens.horizontalPadding >= 6)
    #expect(tokens.verticalPadding > 0)
}