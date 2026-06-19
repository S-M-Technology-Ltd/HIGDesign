import HIGTokensRaw
import HIGTokensSemantic
import Testing

@Test
func opacitySemanticTokensMapRawValues() {
    let tokens = HIGSystemOpacitySemanticTokens()

    #expect(tokens.disabled == HIGOpacity.disabled.rawValue)
    #expect(tokens.subtleFill == HIGOpacity.subtleFill.rawValue)
    #expect(tokens.bannerBorder == HIGOpacity.bannerBorder.rawValue)
}

@Test
func borderSemanticTokensUseHairlineWidth() {
    let tokens = HIGSystemBorderSemanticTokens()

    #expect(tokens.hairline == HIGBorder.hairline.rawValue)
}

@Test
func colorSemanticTokensExposeAccentAndWarningRoles() {
    let colors = HIGSystemColorSemanticTokens()

    #expect(colors.labelOnAccent == .white)
    #expect(colors.warning == .orange)
}