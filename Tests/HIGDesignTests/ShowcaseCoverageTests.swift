import Testing

@Test
func showcaseCatalogIncludesPhaseFourComponents() {
    let catalog: Set<String> = [
        "button",
        "textField",
        "toggle",
        "divider",
        "progressView",
        "card",
        "tabBar",
        "toolbar",
        "alert",
        "toast",
        "sidebar",
        "navigationBar",
    ]

    #expect(catalog.count == 12)
}