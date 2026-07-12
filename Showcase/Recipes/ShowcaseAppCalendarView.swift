import HIGDesign
import SwiftUI

struct ShowcaseAppCalendarView: View {
    @Environment(\.higTheme) private var theme
    @State private var selection = Date()

    private var marks: Set<DateComponents> {
        let calendar = Calendar.current
        let today = calendar.dateComponents([.year, .month, .day], from: Date())
        var mid = today
        mid.day = min((today.day ?? 1) + 2, 28)
        return [today, mid]
    }

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .appCalendar,
            code: """
            HIGPageHeader("Team calendar")
            HIGCalendar(selection: $date, markedDates: events)
            HIGPanel("Agenda") { … }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Team calendar",
                    subtitle: "Month grid with event marks for admin scheduling."
                )
                HIGCalendar(selection: $selection, markedDates: marks)
                HIGPanel("Agenda", description: "Sample day items") {
                    VStack(alignment: .leading, spacing: theme.spacing.item) {
                        agendaRow("Standup", "9:00 AM")
                        HIGDivider()
                        agendaRow("Design sync", "11:30 AM")
                        HIGDivider()
                        agendaRow("Ship review", "3:00 PM")
                    }
                }
            }
        }
    }

    private func agendaRow(_ title: String, _ time: String) -> some View {
        HStack {
            Text(title)
                .font(theme.typography.body)
                .foregroundStyle(theme.colors.labelPrimary)
            Spacer()
            Text(time)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)
        }
    }
}

#if DEBUG
#Preview("ShowcaseAppCalendarView") {
    ShowcasePreviewContainer {
        ShowcaseAppCalendarView()
    }
}
#endif
