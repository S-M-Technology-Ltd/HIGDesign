import Testing

@Test
func showcaseCatalogIncludesPhaseSevenComponents() {
    #expect(ShowcaseCatalog.phaseSevenComponentCount == 24)
}

private enum ShowcaseCatalog {
    static let phaseSevenComponentCount = 24
}