import HIGComponents
import Testing

@Test
func alertButtonRolesAreStable() {
    let roles: [HIGAlertButtonRole] = [.default, .destructive, .cancel]
    #expect(roles.count == 3)
}