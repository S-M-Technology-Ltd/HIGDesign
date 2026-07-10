import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func paginationTokensUseReadableTargets() {
    let tokens = HIGSystemPaginationTokens()
    #expect(tokens.minTapTarget >= 44)
    #expect(tokens.pageMinWidth >= HIGSpacing.xxl.rawValue)
    #expect(tokens.itemSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.borderWidth > 0)
}
