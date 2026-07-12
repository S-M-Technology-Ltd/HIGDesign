import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed month calendar grid for admin scheduling surfaces.
///
/// Supports day selection, month navigation, and optional marked event days.
/// Inspired by Remark Admin calendar apps; chrome resolves from ``HIGTheme/calendar``.
public struct HIGCalendar: View {
    @Binding private var selection: Date
    private let markedDates: Set<DateComponents>
    private let calendar: Calendar

    @State private var visibleMonth: Date
    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a month calendar.
    /// - Parameters:
    ///   - selection: Bound selected day.
    ///   - markedDates: Optional year/month/day components for event markers.
    ///   - calendar: Calendar used for layout and comparisons (default `.current`).
    public init(
        selection: Binding<Date>,
        markedDates: Set<DateComponents> = [],
        calendar: Calendar = .current
    ) {
        _selection = selection
        self.markedDates = markedDates
        self.calendar = calendar
        _visibleMonth = State(initialValue: selection.wrappedValue)
    }

    public var body: some View {
        let tokens = theme.calendar
        let shape = RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
        let capabilities = HIGPlatformCapabilities.current
        let daySize = max(tokens.dayMinSize, capabilities.minimumTouchTarget * 0.75)

        VStack(spacing: tokens.headerSpacing) {
            header(tokens: tokens)
            weekdayHeader(tokens: tokens)
            dayGrid(tokens: tokens, daySize: daySize)
        }
        .padding(tokens.contentPadding)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(theme.colors.backgroundSecondary)
        .clipShape(shape)
        .overlay {
            shape.strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Calendar \(monthYearTitle)")
    }

    private func header(tokens: any HIGCalendarTokens) -> some View {
        HStack {
            Button {
                shiftMonth(by: -1)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: tokens.chevronPointSize, weight: .semibold))
                    .frame(
                        width: HIGSpacing.massive.rawValue,
                        height: HIGSpacing.massive.rawValue
                    )
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .disabled(!isEnabled)
            .accessibilityLabel("Previous month")

            Spacer(minLength: 0)

            Text(monthYearTitle)
                .font(tokens.headerFont)
                .foregroundStyle(theme.colors.labelPrimary)
                .accessibilityAddTraits(.isHeader)

            Spacer(minLength: 0)

            Button {
                shiftMonth(by: 1)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: tokens.chevronPointSize, weight: .semibold))
                    .frame(
                        width: HIGSpacing.massive.rawValue,
                        height: HIGSpacing.massive.rawValue
                    )
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .disabled(!isEnabled)
            .accessibilityLabel("Next month")
        }
        .foregroundStyle(theme.colors.labelPrimary)
    }

    private func weekdayHeader(tokens: any HIGCalendarTokens) -> some View {
        let symbols = calendar.veryShortWeekdaySymbols
        let first = calendar.firstWeekday - 1
        let ordered = Array(symbols[first...]) + Array(symbols[..<first])

        return HStack(spacing: tokens.gridSpacing) {
            ForEach(Array(ordered.enumerated()), id: \.offset) { _, symbol in
                Text(symbol)
                    .font(tokens.weekdayFont)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .accessibilityHidden(true)
    }

    private func dayGrid(tokens: any HIGCalendarTokens, daySize: CGFloat) -> some View {
        let days = monthDays()
        return LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: tokens.gridSpacing), count: 7),
            spacing: tokens.gridSpacing
        ) {
            ForEach(Array(days.enumerated()), id: \.offset) { _, day in
                if let day {
                    dayCell(day, tokens: tokens, daySize: daySize)
                } else {
                    Color.clear
                        .frame(minHeight: daySize)
                }
            }
        }
    }

    private func dayCell(_ day: Date, tokens: any HIGCalendarTokens, daySize: CGFloat) -> some View {
        let isSelected = calendar.isDate(day, inSameDayAs: selection)
        let isToday = calendar.isDateInToday(day)
        let isMarked = isMarkedDay(day)
        let dayNumber = calendar.component(.day, from: day)

        return Button {
            selection = day
            visibleMonth = day
        } label: {
            VStack(spacing: tokens.gridSpacing) {
                Text("\(dayNumber)")
                    .font(tokens.dayFont)
                    .fontWeight(isToday || isSelected ? .semibold : .regular)
                    .foregroundStyle(dayForeground(isSelected: isSelected, isToday: isToday))
                    .frame(maxWidth: .infinity)

                Circle()
                    .fill(isMarked ? (isSelected ? theme.colors.labelOnAccent : theme.colors.accent) : Color.clear)
                    .frame(width: tokens.markSize, height: tokens.markSize)
                    .accessibilityHidden(true)
            }
            .frame(maxWidth: .infinity, minHeight: daySize)
            .background {
                if isSelected {
                    RoundedRectangle(cornerRadius: HIGRadius.sm.rawValue, style: .continuous)
                        .fill(theme.colors.accent)
                } else if isToday {
                    RoundedRectangle(cornerRadius: HIGRadius.sm.rawValue, style: .continuous)
                        .strokeBorder(theme.colors.accent, lineWidth: tokens.borderWidth)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .accessibilityLabel(dayAccessibilityLabel(day, isSelected: isSelected, isMarked: isMarked))
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private func dayForeground(isSelected: Bool, isToday: Bool) -> Color {
        if isSelected {
            theme.colors.labelOnAccent
        } else if isToday {
            theme.colors.accent
        } else {
            theme.colors.labelPrimary
        }
    }

    private var monthYearTitle: String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.locale = calendar.locale
        formatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
        return formatter.string(from: visibleMonth)
    }

    private func shiftMonth(by value: Int) {
        guard let next = calendar.date(byAdding: .month, value: value, to: startOfMonth(visibleMonth)) else {
            return
        }
        visibleMonth = next
    }

    private func startOfMonth(_ date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components) ?? date
    }

    private func monthDays() -> [Date?] {
        let monthStart = startOfMonth(visibleMonth)
        guard let range = calendar.range(of: .day, in: .month, for: monthStart) else {
            return []
        }

        let firstWeekday = calendar.component(.weekday, from: monthStart)
        let leading = (firstWeekday - calendar.firstWeekday + 7) % 7
        var days: [Date?] = Array(repeating: nil, count: leading)

        for day in range {
            var components = calendar.dateComponents([.year, .month], from: monthStart)
            components.day = day
            days.append(calendar.date(from: components))
        }

        while days.count % 7 != 0 {
            days.append(nil)
        }
        return days
    }

    private func isMarkedDay(_ day: Date) -> Bool {
        let components = calendar.dateComponents([.year, .month, .day], from: day)
        return markedDates.contains { mark in
            mark.year == components.year
                && mark.month == components.month
                && mark.day == components.day
        }
    }

    private func dayAccessibilityLabel(_ day: Date, isSelected: Bool, isMarked: Bool) -> String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.locale = calendar.locale
        formatter.dateStyle = .full
        var label = formatter.string(from: day)
        if isSelected {
            label += ", selected"
        }
        if isMarked {
            label += ", has events"
        }
        return label
    }
}

#if DEBUG
#Preview("HIGCalendar") {
    struct HIGCalendarPreviewHostView: View {
        @State private var selection = Date()

        var body: some View {
            HIGThemeableView(theme: HIGComponentPreviewTheme()) {
                HIGCalendar(
                    selection: $selection,
                    markedDates: {
                        let calendar = Calendar.current
                        let today = calendar.dateComponents([.year, .month, .day], from: Date())
                        var second = today
                        second.day = (today.day ?? 1) + 2
                        return [today, second]
                    }()
                )
                .padding()
            }
        }
    }

    return HIGCalendarPreviewHostView()
}
#endif
