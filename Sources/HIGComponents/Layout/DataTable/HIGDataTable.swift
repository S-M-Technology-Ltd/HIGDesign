import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A themed tabular data surface for admin lists and dashboards.
///
/// Renders a header row and data rows with token-backed padding, borders, and
/// optional striping. Prefer ``HIGList`` for simple vertical lists without columns.
public struct HIGDataTable<Row: Identifiable>: View {
    private let rows: [Row]
    private let columns: [HIGDataTableColumn<Row>]
    private let showsHeader: Bool
    private let isStriped: Bool
    private let emptyMessage: String

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a data table.
    /// - Parameters:
    ///   - rows: Ordered row models.
    ///   - columns: Column definitions (title + text provider).
    ///   - showsHeader: When `true`, renders column titles above the body.
    ///   - isStriped: Alternates row background fills for scanability.
    ///   - emptyMessage: Shown when `rows` is empty.
    public init(
        rows: [Row],
        columns: [HIGDataTableColumn<Row>],
        showsHeader: Bool = true,
        isStriped: Bool = true,
        emptyMessage: String = "No data"
    ) {
        self.rows = rows
        self.columns = columns
        self.showsHeader = showsHeader
        self.isStriped = isStriped
        self.emptyMessage = emptyMessage
    }

    public var body: some View {
        let tokens = theme.dataTable
        let capabilities = HIGPlatformCapabilities.current
        let minRowHeight = max(tokens.minRowHeight, capabilities.minimumTouchTarget)

        Group {
            if rows.isEmpty {
                emptyState(tokens: tokens, minRowHeight: minRowHeight)
            } else {
                ScrollView(.horizontal, showsIndicators: true) {
                    VStack(alignment: .leading, spacing: 0) {
                        if showsHeader {
                            headerRow(tokens: tokens, minRowHeight: minRowHeight)
                            separator
                        }
                        ForEach(Array(rows.enumerated()), id: \.element.id) { index, row in
                            dataRow(row, index: index, tokens: tokens, minRowHeight: minRowHeight)
                            if index < rows.count - 1 {
                                separator
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Data table")
        .accessibilityValue("\(rows.count) rows, \(columns.count) columns")
    }

    private var separator: some View {
        Rectangle()
            .fill(theme.colors.separator)
            .frame(height: theme.dataTable.borderWidth)
            .frame(maxWidth: .infinity)
    }

    private func emptyState(tokens: any HIGDataTableTokens, minRowHeight: CGFloat) -> some View {
        Text(emptyMessage)
            .font(tokens.cellFont)
            .foregroundStyle(theme.colors.labelSecondary)
            .frame(maxWidth: .infinity, minHeight: minRowHeight, alignment: .center)
            .padding(.horizontal, tokens.horizontalPadding)
            .padding(.vertical, tokens.verticalPadding)
            .accessibilityLabel(emptyMessage)
    }

    private func headerRow(tokens: any HIGDataTableTokens, minRowHeight: CGFloat) -> some View {
        HStack(alignment: .center, spacing: tokens.columnSpacing) {
            ForEach(columns) { column in
                Text(column.title)
                    .font(tokens.headerFont)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .multilineTextAlignment(textAlignment(column.alignment))
                    .frame(
                        minWidth: column.minWidth ?? tokens.minColumnWidth,
                        alignment: frameAlignment(column.alignment)
                    )
                    .accessibilityAddTraits(.isHeader)
            }
        }
        .padding(.horizontal, tokens.horizontalPadding)
        .padding(.vertical, tokens.verticalPadding)
        .frame(minHeight: minRowHeight, alignment: .leading)
        .background(theme.colors.fillPrimary.opacity(theme.opacity.disabled))
    }

    private func dataRow(
        _ row: Row,
        index: Int,
        tokens: any HIGDataTableTokens,
        minRowHeight: CGFloat
    ) -> some View {
        let striped = isStriped && index.isMultiple(of: 2)
        return HStack(alignment: .center, spacing: tokens.columnSpacing) {
            ForEach(columns) { column in
                Text(column.text(for: row))
                    .font(tokens.cellFont)
                    .foregroundStyle(theme.colors.labelPrimary)
                    .multilineTextAlignment(textAlignment(column.alignment))
                    .frame(
                        minWidth: column.minWidth ?? tokens.minColumnWidth,
                        alignment: frameAlignment(column.alignment)
                    )
            }
        }
        .padding(.horizontal, tokens.horizontalPadding)
        .padding(.vertical, tokens.verticalPadding)
        .frame(minHeight: minRowHeight, alignment: .leading)
        .background(striped ? theme.colors.fillPrimary.opacity(theme.opacity.disabled) : Color.clear)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(rowAccessibilityLabel(row))
    }

    private func rowAccessibilityLabel(_ row: Row) -> String {
        columns.map { "\($0.title): \($0.text(for: row))" }.joined(separator: ", ")
    }

    private func textAlignment(_ alignment: HIGDataTableColumnAlignment) -> TextAlignment {
        switch alignment {
        case .leading: .leading
        case .center: .center
        case .trailing: .trailing
        }
    }

    private func frameAlignment(_ alignment: HIGDataTableColumnAlignment) -> Alignment {
        switch alignment {
        case .leading: .leading
        case .center: .center
        case .trailing: .trailing
        }
    }
}

#if DEBUG
private struct HIGDataTablePreviewPerson: Identifiable {
    let id: Int
    let name: String
    let role: String
    let status: String
}

#Preview("HIGDataTable") {
    let people = [
        HIGDataTablePreviewPerson(id: 1, name: "Alex Rivera", role: "Admin", status: "Active"),
        HIGDataTablePreviewPerson(id: 2, name: "Jordan Lee", role: "Editor", status: "Away"),
        HIGDataTablePreviewPerson(id: 3, name: "Sam Chen", role: "Viewer", status: "Offline"),
    ]

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGDataTable(
            rows: people,
            columns: [
                HIGDataTableColumn("Name", value: \.name),
                HIGDataTableColumn("Role", value: \.role),
                HIGDataTableColumn("Status", alignment: .trailing, value: \.status),
            ]
        )
        .padding()
    }
}
#endif
