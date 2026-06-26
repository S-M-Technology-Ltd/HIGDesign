import HIGDesign
import SwiftUI

struct ShowcaseCheckboxView: View {
    @Environment(\.higTheme) private var theme
    @State private var rememberMe = true
    @State private var marketingEmails = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .checkbox)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: "HIGCheckbox(\"Remember me\", isOn: $rememberMe)") {
                        HIGCheckbox("Remember me", isOn: $rememberMe)
                    }
                    ShowcaseSampleView(code: "HIGCheckbox(\"Marketing emails\", isOn: $marketingEmails)") {
                        HIGCheckbox("Marketing emails", isOn: $marketingEmails)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Checkbox")
    }
}

#if DEBUG
#Preview("ShowcaseCheckboxView") {
    ShowcasePreviewContainer {
        ShowcaseCheckboxView()
    }
}
#endif