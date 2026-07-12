import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func dropZoneTokensUseReadableMetrics() {
    let tokens = HIGSystemDropZoneTokens()
    #expect(tokens.minHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.fileRowMinHeight >= HIGSpacing.md.rawValue)
    #expect(tokens.contentPadding >= HIGSpacing.sm.rawValue)
    #expect(tokens.dashLength >= HIGSpacing.xxs.rawValue)
    #expect(tokens.iconPointSize >= HIGSpacing.lg.rawValue)
}
