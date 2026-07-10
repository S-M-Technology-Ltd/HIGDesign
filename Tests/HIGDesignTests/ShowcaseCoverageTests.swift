import HIGShowcase
import Testing

@Test
func showcaseCatalogIncludesLongTextEditor() {
    let titles = ShowcaseComponent.allCases.map(\.title)
    #expect(ShowcaseComponent.allCases.count == 49)
    #expect(titles.contains("Photo Editor"))
    #expect(titles.contains("Long Text Editor"))
    #expect(titles.contains("Matrix Loader"))
    #expect(titles.contains("Panel"))
    #expect(titles.contains("Breadcrumb"))
    #expect(titles.contains("Page Header"))
    #expect(titles.contains("Pagination"))
    #expect(titles.contains("Tabs"))
    #expect(titles.contains("Accordion"))
    #expect(titles.contains("Steps"))
    #expect(titles.contains("Pearl Steps"))
    #expect(titles.contains("Timeline"))
    #expect(titles.contains("Status Indicator"))
    #expect(titles.contains("Empty State"))
    #expect(titles.contains("Close Button"))
    #expect(titles.contains("Modal"))
    #expect(ShowcaseComponent.allCases.last?.title == "Modal")
}