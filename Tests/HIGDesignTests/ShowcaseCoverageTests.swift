import Testing

@Test
func showcaseCatalogIncludesPhaseNineComponents() {
    #expect(ShowcaseCatalog.phaseNineComponentCount == 32)
}

private enum ShowcaseCatalog {
    static let phaseNineComponentCount = 32
}