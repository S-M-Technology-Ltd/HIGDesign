import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func socialButtonTokensUseReadableMetrics() {
    let tokens = HIGSystemSocialButtonTokens()
    #expect(tokens.minHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.horizontalPadding >= HIGSpacing.xxs.rawValue)
    #expect(tokens.iconPointSize > 0)
    #expect(tokens.iconOnlySize >= HIGSpacing.lg.rawValue)
    #expect(tokens.cornerRadius >= 0)
}

@Test
func socialNetworkProvidesTitlesAndSymbols() {
    for network in HIGSocialNetwork.allCases {
        #expect(!network.defaultTitle.isEmpty)
        #expect(!network.systemImage.isEmpty)
        #expect(!network.accessibilityName.isEmpty)
    }
}
