import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func timelineTokensUseReadableMetrics() {
    let tokens = HIGSystemTimelineTokens()
    #expect(tokens.markerSize >= HIGSpacing.lg.rawValue)
    #expect(tokens.itemSpacing >= HIGSpacing.sm.rawValue)
    #expect(tokens.connectorWidth > 0)
    #expect(tokens.contentLeadingPadding >= HIGSpacing.xs.rawValue)
}

@Test
func timelineItemUsesTitleAsDefaultIdentifier() {
    let item = HIGTimelineItem("Shipped", detail: "UPS", timestamp: "Today", systemImage: "shippingbox")
    #expect(item.id == "Shipped")
    #expect(item.title == "Shipped")
    #expect(item.detail == "UPS")
    #expect(item.timestamp == "Today")
    #expect(item.systemImage == "shippingbox")
}
