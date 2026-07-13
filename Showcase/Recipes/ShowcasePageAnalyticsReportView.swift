import HIGDesign
import SwiftUI

private struct ShowcaseAnalyticsRow: Identifiable {
    let id: Int
    let source: String
    let sessions: String
    let conv: String
    let revenue: String
}

/// Analytics workspace with filters, tabs, charts, and a source table.
struct ShowcasePageAnalyticsReportView: View {
    @Environment(\.higTheme) private var theme
    @State private var tab = "overview"
    @State private var query = ""
    @State private var product: String? = "All products"

    private let rows: [ShowcaseAnalyticsRow] = [
        .init(id: 1, source: "App Store", sessions: "4,820", conv: "4.1%", revenue: "$18.2k"),
        .init(id: 2, source: "Web", sessions: "3,110", conv: "2.6%", revenue: "$9.4k"),
        .init(id: 3, source: "Email", sessions: "1,240", conv: "6.8%", revenue: "$7.1k"),
        .init(id: 4, source: "Partners", sessions: "890", conv: "3.2%", revenue: "$3.0k"),
    ]

    private var columns: [HIGDataTableColumn<ShowcaseAnalyticsRow>] {
        [
            HIGDataTableColumn("Source", minWidth: 120, value: \.source),
            HIGDataTableColumn("Sessions", value: \.sessions),
            HIGDataTableColumn("Conv.", value: \.conv),
            HIGDataTableColumn("Revenue", alignment: .trailing, value: \.revenue),
        ]
    }

    private let trend: [HIGChartPoint] = [
        HIGChartPoint(label: "W1", value: 22),
        HIGChartPoint(label: "W2", value: 28),
        HIGChartPoint(label: "W3", value: 25),
        HIGChartPoint(label: "W4", value: 34),
        HIGChartPoint(label: "W5", value: 31),
        HIGChartPoint(label: "W6", value: 39),
    ]

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageAnalyticsReport,
            code: """
            HIGPageHeader("Analytics")
            HIGTabs + filters
            HIGLineChart / HIGBarChart
            HIGDataTable(rows: sources)
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Analytics",
                    subtitle: "Product funnel and acquisition report for stakeholders."
                ) {
                    HIGButton("Share", role: .secondary) {}
                }

                HIGTabs(
                    selection: $tab,
                    items: [
                        HIGTabsItem(id: "overview", title: "Overview"),
                        HIGTabsItem(id: "acquisition", title: "Acquisition"),
                        HIGTabsItem(id: "revenue", title: "Revenue"),
                    ]
                )

                HStack(spacing: theme.spacing.item) {
                    HIGSearchField("Search sources", text: $query, placeholder: "Filter table")
                    HIGSelect(
                        "Product",
                        selection: $product,
                        options: [
                            HIGRadioOption(value: "All products", label: "All products"),
                            HIGRadioOption(value: "iOS app", label: "iOS app"),
                            HIGRadioOption(value: "Web", label: "Web"),
                            HIGRadioOption(value: "API", label: "API"),
                        ]
                    )
                }

                Group {
                    switch tab {
                    case "acquisition":
                        HIGWidget("New users by week") {
                            HIGBarChart(points: trend)
                        }
                    case "revenue":
                        HIGWidget("Revenue trend") {
                            HIGLineChart(points: trend)
                        }
                    default:
                        HIGDashboardGrid {
                            HIGCounter("Sessions", value: "10.1k", trend: .up, trendLabel: "+9%")
                            HIGCounter("ARPU", value: "$4.12", trend: .up, trendLabel: "+$0.18")
                            HIGWidget("Engagement") {
                                HIGLineChart(points: trend)
                            }
                        }
                    }
                }

                HIGPanel("Sources", description: filteredRows.count == rows.count ? "All channels" : "Filtered") {
                    HIGDataTable(rows: filteredRows, columns: columns, emptyMessage: "No sources match")
                }
            }
        }
    }

    private var filteredRows: [ShowcaseAnalyticsRow] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return rows }
        return rows.filter { $0.source.localizedCaseInsensitiveContains(q) }
    }
}

#if DEBUG
#Preview("ShowcasePageAnalyticsReportView") {
    ShowcasePreviewContainer { ShowcasePageAnalyticsReportView() }
}
#endif
