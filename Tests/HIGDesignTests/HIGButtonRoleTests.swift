import HIGComponents
import Testing

@Test
func buttonRolesAreStable() {
    #expect(HIGButtonRole.allCases.count == 4)
    #expect(HIGButtonRole.primary != .destructive)
}