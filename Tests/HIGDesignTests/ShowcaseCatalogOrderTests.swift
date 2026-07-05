import HIGShowcase
import Testing

@Test
func showcaseCatalogSortsComponentsAlphabeticallyByTitle() {
    let titles = ShowcaseComponent.catalogSorted.map(\.title)
    let expected = titles.sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }

    #expect(titles == expected)
    #expect(titles.first == "Activity Indicator")
    #expect(titles.contains("Photo Picker"))
    #expect(titles.contains("Long Text Editor"))
}