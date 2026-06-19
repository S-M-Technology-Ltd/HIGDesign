import HIGTokensComponent
import Testing

@Test
func sidebarTokensUseReadableSpacing() {
    let tokens = HIGSystemSidebarTokens()
    #expect(tokens.rowSpacing >= 4)
    #expect(tokens.rowPadding >= 4)
}