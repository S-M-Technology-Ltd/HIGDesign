import HIGShowcase
import Testing

@Test
func showcaseCatalogIncludesLongTextEditor() {
    let titles = ShowcaseComponent.allCases.map(\.title)
    #expect(ShowcaseComponent.allCases.count == 36)
    #expect(titles.contains("Photo Editor"))
    #expect(titles.contains("Long Text Editor"))
    #expect(titles.contains("Matrix Loader"))
    #expect(ShowcaseComponent.allCases.last?.title == "Long Text Editor")
}