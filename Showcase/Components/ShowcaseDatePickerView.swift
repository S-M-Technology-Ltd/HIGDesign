import HIGDesign
import SwiftUI

struct ShowcaseDatePickerView: View {
    @Environment(\.higTheme) private var theme
    @State private var startDate = Date()
    @State private var deadline = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()

    private var nextYear: ClosedRange<Date> {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: Date())
        let end = calendar.date(byAdding: .year, value: 1, to: start) ?? start
        return start...end
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .datePicker)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGDatePicker("Start date", selection: $startDate)
                    HIGDatePicker("Deadline", selection: $deadline, in: nextYear)
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGDatePicker("Start date", selection: $startDate)
                            HIGDatePicker("Deadline", selection: $deadline, in: nextYear)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGDatePicker("Disabled", selection: $startDate)
                        .disabled(true)
                    """) {
                        HIGDatePicker("Disabled", selection: $startDate)
                            .disabled(true)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Date Picker")
    }
}

#if DEBUG
#Preview("ShowcaseDatePickerView") {
    ShowcasePreviewContainer {
        ShowcaseDatePickerView()
    }
}
#endif
