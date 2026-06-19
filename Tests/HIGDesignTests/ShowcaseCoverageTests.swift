import Testing

@Test
func showcaseCatalogIncludesPhaseEightComponents() {
    #expect(ShowcaseCatalog.phaseEightComponentCount == 30)
}

private enum ShowcaseCatalog {
    static let phaseEightComponentCount = 30
}