import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// An adaptive multi-column grid for admin dashboard widgets and counters.
///
/// Columns reflow based on available width using ``HIGDashboardGridTokens/minColumnWidth``.
/// Place ``HIGWidget``, ``HIGCounter``, ``HIGPanel``, or charts as children.
/// Inspired by Remark Admin dashboard layouts; spacing resolves from ``HIGTheme/dashboardGrid``.
public struct HIGDashboardGrid<Content: View>: View {
    private let title: String?
    private let content: () -> Content

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a dashboard grid.
    /// - Parameters:
    ///   - title: Optional section heading above the grid.
    ///   - content: Grid children (typically widgets or counters).
    public init(
        _ title: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.content = content
    }

    public var body: some View {
        let tokens = theme.dashboardGrid
        let columns = [
            GridItem(
                .adaptive(minimum: tokens.minColumnWidth),
                spacing: tokens.columnSpacing,
                alignment: .top
            )
        ]

        VStack(alignment: .leading, spacing: tokens.titleSpacing) {
            if let title {
                Text(title)
                    .font(tokens.titleFont)
                    .foregroundStyle(theme.colors.labelPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityAddTraits(.isHeader)
            }

            LazyVGrid(columns: columns, alignment: .leading, spacing: tokens.rowSpacing) {
                content()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(title ?? "Dashboard grid")
    }
}

#if DEBUG
#Preview("HIGDashboardGrid") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGDashboardGrid("Overview") {
            HIGCounter(
                "Users",
                value: "1,284",
                caption: "Last 7 days",
                systemImage: "person.2",
                trend: .up,
                trendLabel: "+12%"
            )
            HIGCounter(
                "Sessions",
                value: "8,420",
                trend: .up,
                trendLabel: "+6%"
            )
            HIGWidget("Traffic") {
                Text("Chart placeholder")
            }
        }
        .padding()
    }
}
#endif
