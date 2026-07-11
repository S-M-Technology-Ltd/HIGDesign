import CoreGraphics
import Foundation

/// A text column definition for ``HIGDataTable``.
public struct HIGDataTableColumn<Row: Identifiable>: Identifiable {
    public let id: String
    public let title: String
    public let minWidth: CGFloat?
    public let alignment: HIGDataTableColumnAlignment
    private let textProvider: (Row) -> String

    /// Creates a column with a custom text provider.
    public init(
        _ title: String,
        id: String? = nil,
        minWidth: CGFloat? = nil,
        alignment: HIGDataTableColumnAlignment = .leading,
        text: @escaping (Row) -> String
    ) {
        self.id = id ?? title
        self.title = title
        self.minWidth = minWidth
        self.alignment = alignment
        self.textProvider = text
    }

    /// Creates a column bound to a string key path.
    public init(
        _ title: String,
        id: String? = nil,
        minWidth: CGFloat? = nil,
        alignment: HIGDataTableColumnAlignment = .leading,
        value: KeyPath<Row, String>
    ) {
        self.id = id ?? title
        self.title = title
        self.minWidth = minWidth
        self.alignment = alignment
        self.textProvider = { row in row[keyPath: value] }
    }

    /// Creates a column bound to a custom-string-convertible key path.
    public init<Value: CustomStringConvertible>(
        _ title: String,
        id: String? = nil,
        minWidth: CGFloat? = nil,
        alignment: HIGDataTableColumnAlignment = .leading,
        value: KeyPath<Row, Value>
    ) {
        self.id = id ?? title
        self.title = title
        self.minWidth = minWidth
        self.alignment = alignment
        self.textProvider = { row in row[keyPath: value].description }
    }

    public func text(for row: Row) -> String {
        textProvider(row)
    }
}

/// Horizontal text alignment for table columns.
public enum HIGDataTableColumnAlignment: String, Sendable, CaseIterable {
    case leading
    case center
    case trailing
}
