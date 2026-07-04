import HIGTokensComponent
import Testing

@Test
func longTextEditorTokensExposeMinimumHeightAndToolbarMetrics() {
    let tokens = HIGSystemLongTextEditorTokens()

    #expect(tokens.minHeight >= 120)
    #expect(tokens.toolbarHeight >= 44)
    #expect(tokens.editorFontSize > 0)
    #expect(tokens.editorLineHeight > 1)
}