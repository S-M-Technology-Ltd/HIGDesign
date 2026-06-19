import HIGComponents
import Testing

@Test
func tabItemPreservesIdentityAndLabel() {
    let item = HIGTabItem(id: "home", title: "Home", systemImage: "house")
    #expect(item.id == "home")
    #expect(item.title == "Home")
    #expect(item.systemImage == "house")
}