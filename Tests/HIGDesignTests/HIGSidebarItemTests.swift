import HIGComponents
import Testing

@Test
func sidebarItemPreservesIdentity() {
    let item = HIGSidebarItem(id: 1, title: "Inbox", systemImage: "tray")
    #expect(item.id == 1)
    #expect(item.title == "Inbox")
}