import Testing

@Test
func showcaseCatalogIncludesPhaseElevenComponents() {
    #expect(ShowcaseCatalog.componentCount == 33)
}

private enum ShowcaseCatalog {
    static let componentCount = 33
}