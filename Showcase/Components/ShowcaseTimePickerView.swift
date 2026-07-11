import HIGDesign
import SwiftUI

struct ShowcaseTimePickerView: View {
    @Environment(\.higTheme) private var theme
    @State private var startTime = Date()
    @State private var endTime = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .timePicker)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGTimePicker("Start time", selection: $startTime)
                    HIGTimePicker("End time", selection: $endTime)
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGTimePicker("Start time", selection: $startTime)
                            HIGTimePicker("End time", selection: $endTime)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGTimePicker("Disabled", selection: $startTime)
                        .disabled(true)
                    """) {
                        HIGTimePicker("Disabled", selection: $startTime)
                            .disabled(true)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Time Picker")
    }
}

#if DEBUG
#Preview("ShowcaseTimePickerView") {
    ShowcasePreviewContainer {
        ShowcaseTimePickerView()
    }
}
#endif
