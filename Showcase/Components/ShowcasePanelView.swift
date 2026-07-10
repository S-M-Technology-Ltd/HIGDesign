import HIGDesign
import SwiftUI

struct ShowcasePanelView: View {
    @Environment(\.higTheme) private var theme
    @State private var isCollapsed = false
    @State private var refreshCount = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .panel)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGPanel("Overview", description: "Weekly summary") {
                        Text("Body content")
                    }
                    """) {
                        HIGPanel("Overview", description: "Weekly summary") {
                            Text("Body content for dashboard panels.")
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGPanel(
                        HIGPanelOptions(
                            title: "Activity",
                            description: "Collapsible",
                            showsCollapseControl: true
                        ),
                        isCollapsed: $isCollapsed,
                        actions: HIGPanelActions(
                            onRefresh: { /* reload */ },
                            onClose: { /* dismiss */ }
                        )
                    ) {
                        Text("Collapsible body")
                    } footer: {
                        Text("Footer")
                    }
                    """) {
                        HIGPanel(
                            HIGPanelOptions(
                                title: "Activity",
                                description: "Refreshed \(refreshCount) times",
                                showsCollapseControl: true
                            ),
                            isCollapsed: $isCollapsed,
                            actions: HIGPanelActions(
                                onRefresh: { refreshCount += 1 },
                                onClose: {}
                            )
                        ) {
                            Text("Collapsible body with themed chrome.")
                                .foregroundStyle(theme.colors.labelSecondary)
                        } footer: {
                            Text("Optional footer")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Panel")
    }
}

#if DEBUG
#Preview("ShowcasePanelView") {
    ShowcasePreviewContainer {
        ShowcasePanelView()
    }
}
#endif
