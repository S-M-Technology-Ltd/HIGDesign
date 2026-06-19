import Testing

@Test
func showcaseCatalogIncludesPhaseThreeComponents() {
    let expected: Set<String> = [
        "button",
        "textField",
        "toggle",
        "divider",
        "progressView",
        "card",
        "tabBar",
        "toolbar",
    ]

    let catalog = Set([
        "button",
        "textField",
        "toggle",
        "divider",
        "progressView",
        "card",
        "tabBar",
        "toolbar",
    ])

    #expect(catalog == expected)
    #expect(catalog.count == 8)
}