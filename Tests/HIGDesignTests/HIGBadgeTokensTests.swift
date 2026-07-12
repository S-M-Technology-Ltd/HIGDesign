import HIGComponents
import HIGTokensComponent
import Testing

@Test
func badgeTokensUseCompactPadding() {
    let tokens = HIGSystemBadgeTokens()
    #expect(tokens.horizontalPadding >= 6)
    #expect(tokens.verticalPadding > 0)
}

@Test
func badgeStylesIncludeSemanticRoles() {
    #expect(HIGBadgeStyle.allCases.contains(.success))
    #expect(HIGBadgeStyle.allCases.contains(.warning))
    #expect(HIGBadgeStyle.allCases.contains(.info))
    #expect(HIGBadgeStyle.allCases.count == 6)
}