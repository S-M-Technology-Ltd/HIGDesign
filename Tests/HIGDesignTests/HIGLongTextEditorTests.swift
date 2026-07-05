import Testing

#if canImport(WebKit) && (os(iOS) || os(macOS) || os(visionOS))
import HIGComponents
import Foundation

@Test
@MainActor
func longTextEditorConfigurationDefaultsEnableSpellCheck() {
    let configuration = HIGLongTextEditorConfiguration()

    #expect(configuration.spellCheckEnabled)
    #expect(configuration.autoCorrectEnabled)
    #expect(configuration.toolbarPlacement == .inline)
}

@Test
@MainActor
func longTextAttributesStartsWithFormattingFlagsDisabled() {
    let attributes = HIGLongTextAttributes()

    #expect(!attributes.hasBold)
    #expect(!attributes.hasItalic)
    #expect(!attributes.hasUnderline)
    #expect(!attributes.hasStrikethrough)
}
#endif