import HIGDesign
import SwiftUI

struct ShowcaseCalendarView: View {
    @Environment(\.higTheme) private var theme
    @State private var selection = Date()
    @State private var markedSelection = Date()

    private var sampleMarks: Set<DateComponents> {
        let calendar = Calendar.current
        let today = calendar.dateComponents([.year, .month, .day], from: Date())
        var later = today
        later.day = min((today.day ?? 1) + 3, 28)
        var earlier = today
        earlier.day = max((today.day ?? 1) - 2, 1)
        return [today, later, earlier]
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .calendar)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGCalendar(selection: $date)
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGCalendar(selection: $selection)
                            Text("Selected: \(formatted(selection))")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGCalendar(
                        selection: $date,
                        markedDates: eventDays
                    )
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGCalendar(
                                selection: $markedSelection,
                                markedDates: sampleMarks
                            )
                            Text("Dots mark sample events")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Calendar")
    }

    private func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#if DEBUG
#Preview("ShowcaseCalendarView") {
    ShowcasePreviewContainer {
        ShowcaseCalendarView()
    }
}
#endif
