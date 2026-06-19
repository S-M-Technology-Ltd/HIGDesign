import HIGTokensRaw
import Testing

@Test
func spacingUsesFourPointGrid() {
    #expect(HIGSpacing.sm.rawValue == 8)
    #expect(HIGSpacing.lg.rawValue == 16)
    #expect(HIGSpacing.xxl.rawValue == 24)
}