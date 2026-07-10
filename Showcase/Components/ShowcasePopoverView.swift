import HIGDesign
import SwiftUI

struct ShowcasePopoverView: View {
    @Environment(\.higTheme) private var theme
    @State private var isPresented = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .popover)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGButton("Filters", role: .secondary) {
                        isPresented = true
                    }
                    .higPopover(isPresented: $isPresented) {
                        Text("Choose a date range.")
                    }
                    """) {
                        HIGButton("Filters", role: .secondary) {
                            isPresented.toggle()
                        }
                        .higPopover(isPresented: $isPresented) {
                            VStack(alignment: .leading, spacing: theme.spacing.item) {
                                Text("Filters")
                                    .font(theme.typography.headline)
                                    .foregroundStyle(theme.colors.labelPrimary)
                                Text("Choose a date range and status.")
                                    .font(theme.typography.body)
                                    .foregroundStyle(theme.colors.labelSecondary)
                                HIGButton("Apply", role: .primary) {
                                    isPresented = false
                                }
                            }
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGPopoverContainer {
                        Text("Static popover chrome")
                    }
                    """) {
                        HIGPopoverContainer {
                            Text("Static popover chrome preview.")
                                .font(theme.typography.body)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Popover")
    }
}

#if DEBUG
#Preview("ShowcasePopoverView") {
    ShowcasePreviewContainer {
        ShowcasePopoverView()
    }
}
#endif
