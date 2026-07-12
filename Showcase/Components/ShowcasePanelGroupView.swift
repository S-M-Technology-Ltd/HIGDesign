import HIGDesign
import SwiftUI

struct ShowcasePanelGroupView: View {
    @Environment(\.higTheme) private var theme
    @State private var isCollapsed = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .panelGroup)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGPanelGroup("Dashboard") {
                        HIGPanel("Overview", description: "Weekly summary") {
                            Text("Body A")
                        }
                        HIGPanel("Activity", description: "Recent events") {
                            Text("Body B")
                        }
                    }
                    """) {
                        HIGPanelGroup("Dashboard") {
                            HIGPanel("Overview", description: "Weekly summary") {
                                Text("Compose panels in a vertical group.")
                                    .font(theme.typography.body)
                                    .foregroundStyle(theme.colors.labelSecondary)
                            }
                            HIGPanel("Activity", description: "Recent events") {
                                Text("Spacing comes from theme.panelGroup.")
                                    .font(theme.typography.body)
                                    .foregroundStyle(theme.colors.labelSecondary)
                            }
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGPanelGroup {
                        HIGWidget("Users") {
                            HIGCounter("Active", value: "1,284", trend: .up, trendLabel: "+12%")
                        }
                        HIGPanel(
                            HIGPanelOptions(title: "Notes", showsCollapseControl: true),
                            isCollapsed: $isCollapsed
                        ) {
                            Text("Collapsible panel in a group")
                        }
                    }
                    """) {
                        HIGPanelGroup {
                            HIGWidget("Users") {
                                HIGCounter(
                                    "Active",
                                    value: "1,284",
                                    systemImage: "person.2",
                                    trend: .up,
                                    trendLabel: "+12%"
                                )
                            }
                            HIGPanel(
                                HIGPanelOptions(
                                    title: "Notes",
                                    description: "Optional collapse",
                                    showsCollapseControl: true
                                ),
                                isCollapsed: $isCollapsed
                            ) {
                                Text("Mix widgets and panels in one group.")
                                    .font(theme.typography.body)
                                    .foregroundStyle(theme.colors.labelSecondary)
                            }
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Panel Group")
    }
}

#if DEBUG
#Preview("ShowcasePanelGroupView") {
    ShowcasePreviewContainer {
        ShowcasePanelGroupView()
    }
}
#endif
