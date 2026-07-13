import HIGDesign
import SwiftUI

/// Multi-widget operations dashboard: KPIs, charts, alerts, and activity.
struct ShowcasePageOpsDashboardView: View {
    @Environment(\.higTheme) private var theme
    @State private var range = "7d"

    private let traffic: [HIGChartPoint] = [
        HIGChartPoint(label: "Mon", value: 42),
        HIGChartPoint(label: "Tue", value: 58),
        HIGChartPoint(label: "Wed", value: 51),
        HIGChartPoint(label: "Thu", value: 73),
        HIGChartPoint(label: "Fri", value: 66),
        HIGChartPoint(label: "Sat", value: 40),
        HIGChartPoint(label: "Sun", value: 37),
    ]

    private let activity = [
        HIGTimelineItem(id: "deploy", title: "Production deploy", detail: "v1.5.1 rolled out to 100%.", timestamp: "9:12 AM", systemImage: "shippingbox"),
        HIGTimelineItem(id: "alert", title: "Latency alert cleared", detail: "p95 back under 180ms.", timestamp: "8:40 AM", systemImage: "waveform.path.ecg"),
        HIGTimelineItem(id: "invite", title: "Team invite accepted", detail: "Sam Rivera joined Platform.", timestamp: "Yesterday", systemImage: "person.badge.plus"),
    ]

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageOpsDashboard,
            code: """
            HIGPageHeader("Operations")
            HIGDashboardGrid { HIGCounter… HIGWidget { HIGAreaChart… } }
            HIGAlertBanner(…, style: .warning)
            HIGTimeline(items: activity)
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Operations",
                    subtitle: "Live admin dashboard composed from counters, charts, and timeline.",
                    breadcrumbItems: [
                        HIGBreadcrumbItem(id: "home", title: "Home"),
                        HIGBreadcrumbItem(id: "ops", title: "Operations"),
                    ]
                ) {
                    HIGButtonGroup {
                        HIGButton("Export", role: .secondary) {}
                        HIGButton("Refresh", role: .primary) {}
                    }
                }

                HIGSegmentedControl(
                    "Range",
                    selection: $range,
                    options: [
                        HIGRadioOption(value: "24h", label: "24h"),
                        HIGRadioOption(value: "7d", label: "7d"),
                        HIGRadioOption(value: "30d", label: "30d"),
                    ]
                )

                HIGAlertBanner(
                    "Elevated error rate on checkout",
                    message: "0.8% of payments failed in the last hour. Investigate Stripe webhooks.",
                    style: .warning,
                    actionTitle: "Open runbook",
                    onDismiss: {}
                )

                HIGDashboardGrid("Key metrics") {
                    HIGCounter("Active users", value: "12.4k", caption: rangeLabel, systemImage: "person.2", trend: .up, trendLabel: "+6%")
                    HIGCounter("Conversion", value: "3.8%", caption: "Checkout", systemImage: "cart", trend: .down, trendLabel: "-0.2%")
                    HIGCounter("p95 latency", value: "162ms", caption: "API edge", systemImage: "timer", trend: .down, trendLabel: "-12ms")
                    HIGCounter("Open incidents", value: "2", caption: "Sev-2", systemImage: "exclamationmark.triangle", trend: .up, trendLabel: "+1")
                }

                HIGDashboardGrid {
                    HIGWidget("Traffic", subtitle: "Sessions") {
                        HIGAreaChart(points: traffic)
                    }
                    HIGWidget("Mix", subtitle: "Channels") {
                        HIGPieChart(points: [
                            HIGChartPoint(label: "Organic", value: 44),
                            HIGChartPoint(label: "Paid", value: 28),
                            HIGChartPoint(label: "Referral", value: 18),
                            HIGChartPoint(label: "Email", value: 10),
                        ])
                    }
                }

                HIGPanel("Activity", description: "Audit trail for the last 24 hours") {
                    HIGTimeline(items: activity)
                }
            }
        }
    }

    private var rangeLabel: String {
        switch range {
        case "24h": "Last 24 hours"
        case "30d": "Last 30 days"
        default: "Last 7 days"
        }
    }
}

#if DEBUG
#Preview("ShowcasePageOpsDashboardView") {
    ShowcasePreviewContainer { ShowcasePageOpsDashboardView() }
}
#endif
