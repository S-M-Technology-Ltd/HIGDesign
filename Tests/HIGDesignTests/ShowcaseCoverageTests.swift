import HIGShowcase
import Testing

@Test
func showcaseCatalogIncludesLongTextEditor() {
    let titles = ShowcaseComponent.allCases.map(\.title)
    #expect(ShowcaseComponent.allCases.count == 42)
    #expect(titles.contains("Photo Editor"))
    #expect(titles.contains("Long Text Editor"))
    #expect(titles.contains("Matrix Loader"))
    #expect(titles.contains("Panel"))
    #expect(titles.contains("Breadcrumb"))
    #expect(titles.contains("Page Header"))
    #expect(titles.contains("Pagination"))
    #expect(titles.contains("Tabs"))
    #expect(titles.contains("Accordion"))
    #expect(ShowcaseComponent.allCases.last?.title == "Accordion")
}