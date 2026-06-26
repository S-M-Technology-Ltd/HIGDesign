import HIGTokensComponent
import Testing

@Test
func iconTokensDefineSizeScale() {
    let tokens = HIGSystemIconTokens()
    #expect(tokens.smallSize > 0)
    #expect(tokens.mediumSize > tokens.smallSize)
    #expect(tokens.largeSize > tokens.mediumSize)
    #expect(HIGIconSize.medium.basePointSize(tokens: tokens) == tokens.mediumSize)
    #expect(HIGIconSize.fixed(36).basePointSize(tokens: tokens) == 36)
}

@Test
func avatarTokensUseMinimumTouchDiameter() {
    let tokens = HIGSystemAvatarTokens()
    #expect(tokens.diameter >= 44)
}

@Test
func bulletListTokensDefineSpacing() {
    let tokens = HIGSystemBulletListTokens()
    #expect(tokens.itemSpacing > 0)
    #expect(tokens.bulletSpacing > 0)
}