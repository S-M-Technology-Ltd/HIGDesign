import HIGDesign
import SwiftUI

struct ShowcaseButtonGroupView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .buttonGroup)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGButtonGroup {
                        HIGButton("Cancel", role: .secondary) {}
                        HIGButton("Save", role: .primary) {}
                    }
                    """) {
                        HIGButtonGroup {
                            HIGButton("Cancel", role: .secondary) {}
                            HIGButton("Save", role: .primary) {}
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGButtonGroup(equalWidth: true) {
                        HIGButton("Edit", role: .secondary) {}
                        HIGButton("Share", role: .secondary) {}
                        HIGButton("Delete", role: .destructive) {}
                    }
                    """) {
                        HIGButtonGroup(equalWidth: true) {
                            HIGButton("Edit", role: .secondary) {}
                            HIGButton("Share", role: .secondary) {}
                            HIGButton("Delete", role: .destructive) {}
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGButtonGroup(axis: .vertical) {
                        HIGButton("Continue", role: .primary) {}
                        HIGButton("Not now", role: .borderless) {}
                    }
                    """) {
                        HIGButtonGroup(axis: .vertical) {
                            HIGButton("Continue", role: .primary) {}
                            HIGButton("Not now", role: .borderless) {}
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Button Group")
    }
}

#if DEBUG
#Preview("ShowcaseButtonGroupView") {
    ShowcasePreviewContainer {
        ShowcaseButtonGroupView()
    }
}
#endif
