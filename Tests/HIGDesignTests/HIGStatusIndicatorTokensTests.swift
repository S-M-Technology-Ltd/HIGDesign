import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func statusIndicatorTokensUseReadableMetrics() {
    let tokens = HIGSystemStatusIndicatorTokens()
    #expect(tokens.diameter >= HIGSpacing.sm.rawValue)
    #expect(tokens.avatarBadgeDiameter > 0)
    #expect(tokens.borderWidth > 0)
}

@Test
func statusKindCasesAreStable() {
    #expect(HIGStatusKind.allCases.count == 4)
    #expect(HIGStatusKind.online.accessibilityLabel == "Online")
    #expect(HIGStatusKind.offline.accessibilityLabel == "Offline")
}
