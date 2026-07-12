import HIGDesign
import SwiftUI

struct ShowcaseAppTaskboardView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .appTaskboard,
            code: """
            HIGPageHeader("Taskboard")
            HStack {
                HIGPanel("To do") { cards… }
                HIGPanel("Doing") { cards… }
                HIGPanel("Done") { cards… }
            }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Taskboard",
                    subtitle: "Kanban-style columns as HIGPanel stacks — host owns persistence."
                )
                #if os(watchOS)
                VStack(spacing: theme.spacing.item) {
                    column("To do", tasks: ["Write recipes", "Wire catalog"])
                    column("Doing", tasks: ["Verify PR gate"])
                    column("Done", tasks: ["Map recipe"])
                }
                #else
                HStack(alignment: .top, spacing: theme.spacing.item) {
                    column("To do", tasks: ["Write recipes", "Wire catalog"])
                    column("Doing", tasks: ["Verify PR gate"])
                    column("Done", tasks: ["Map recipe"])
                }
                #endif
            }
        }
    }

    private func column(_ title: String, tasks: [String]) -> some View {
        HIGPanel(title, description: "\(tasks.count) cards") {
            VStack(alignment: .leading, spacing: theme.spacing.item) {
                ForEach(tasks, id: \.self) { task in
                    HIGCard {
                        Text(task)
                            .font(theme.typography.callout)
                            .foregroundStyle(theme.colors.labelPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

#if DEBUG
#Preview("ShowcaseAppTaskboardView") {
    ShowcasePreviewContainer {
        ShowcaseAppTaskboardView()
    }
}
#endif
