import HIGDesign
import SwiftUI

struct ShowcaseFieldMessageView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .fieldMessage)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGFieldMessage("Use your work email.")
                    HIGFieldMessage("Required.", kind: .error)
                    HIGFieldMessage("Looks good.", kind: .success)
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGFieldMessage("Use your work email address.")
                            HIGFieldMessage("Email is required.", kind: .error)
                            HIGFieldMessage("Looks good.", kind: .success)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Field Message")
    }
}

#if DEBUG
#Preview("ShowcaseFieldMessageView") {
    ShowcasePreviewContainer {
        ShowcaseFieldMessageView()
    }
}
#endif
