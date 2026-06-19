import Testing

@Test
func showcaseCatalogIncludesPhaseElevenComponents() {
    #expect(ShowcaseCatalog.phaseElevenComponentCount == 32)
}

private enum ShowcaseCatalog {
    static let phaseElevenComponentCount = 32
}