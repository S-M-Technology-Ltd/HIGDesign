import HIGDesign
import SwiftUI

struct ShowcaseAccordionView: View {
    @Environment(\.higTheme) private var theme
    @State private var multiExpanded: Set<String> = ["billing"]
    @State private var singleExpanded: Set<String> = ["one"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .accordion)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGAccordion {
                        HIGAccordionSection(
                            id: "profile",
                            title: "Profile",
                            expandedIDs: $expanded
                        ) { Text("…") }
                    }
                    """) {
                        HIGAccordion {
                            HIGAccordionSection(
                                id: "profile",
                                title: "Profile",
                                expandedIDs: $multiExpanded
                            ) {
                                Text("Name, email, and avatar settings.")
                            }
                            HIGAccordionSection(
                                id: "billing",
                                title: "Billing",
                                expandedIDs: $multiExpanded
                            ) {
                                Text("Invoices and payment methods.")
                            }
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGAccordionSection(
                        …,
                        allowsMultipleExpanded: false
                    )
                    """) {
                        HIGAccordion {
                            HIGAccordionSection(
                                id: "one",
                                title: "Only one open",
                                expandedIDs: $singleExpanded,
                                allowsMultipleExpanded: false
                            ) {
                                Text("Opening another section collapses this one.")
                            }
                            HIGAccordionSection(
                                id: "two",
                                title: "Second section",
                                expandedIDs: $singleExpanded,
                                allowsMultipleExpanded: false
                            ) {
                                Text("Exclusive expansion mode.")
                            }
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Accordion")
    }
}

#if DEBUG
#Preview("ShowcaseAccordionView") {
    ShowcasePreviewContainer {
        ShowcaseAccordionView()
    }
}
#endif
