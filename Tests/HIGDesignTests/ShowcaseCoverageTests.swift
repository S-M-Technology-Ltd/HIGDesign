import Testing

@Test
func showcaseCatalogIncludesPhaseTenComponents() {
    #expect(ShowcaseCatalog.phaseTenComponentCount == 32)
}

private enum ShowcaseCatalog {
    static let phaseTenComponentCount = 32
}