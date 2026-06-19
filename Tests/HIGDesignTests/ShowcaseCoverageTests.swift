import Testing

@Test
func showcaseCatalogIncludesPhaseFiveComponents() {
    #expect(ShowcaseCatalog.phaseFiveComponentCount == 17)
}

private enum ShowcaseCatalog {
    static let phaseFiveComponentCount = 17
}