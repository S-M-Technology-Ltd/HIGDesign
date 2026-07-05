import HIGComponents
import Testing

@Test
func buttonRolesAreStable() {
    #expect(HIGButtonRole.allCases.count == 4)
    #expect(HIGButtonRole.primary != .destructive)
}

@Test
func buttonStylesIncludeGlass() {
    #expect(HIGButtonStyle.allCases.count == 2)
    #expect(HIGButtonStyle.allCases.contains(.glass))
    #expect(HIGButtonStyle.allCases.contains(.standard))
}