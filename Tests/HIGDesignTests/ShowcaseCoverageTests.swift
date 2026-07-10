import HIGShowcase
import Testing

@Test
func showcaseCatalogIncludesLongTextEditor() {
    let titles = ShowcaseComponent.allCases.map(\.title)
    #expect(ShowcaseComponent.allCases.count == 39)
    #expect(titles.contains("Photo Editor"))
    #expect(titles.contains("Long Text Editor"))
    #expect(titles.contains("Matrix Loader"))
    #expect(titles.contains("Panel"))
    #expect(titles.contains("Breadcrumb"))
    #expect(titles.contains("Page Header"))
    #expect(ShowcaseComponent.allCases.last?.title == "Page Header")
}