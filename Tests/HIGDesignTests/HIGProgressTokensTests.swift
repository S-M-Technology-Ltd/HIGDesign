import HIGTokensComponent
import Testing

@Test
func progressTokensUseVisibleTrackHeight() {
    let tokens = HIGSystemProgressTokens()
    #expect(tokens.trackHeight > 0)
}