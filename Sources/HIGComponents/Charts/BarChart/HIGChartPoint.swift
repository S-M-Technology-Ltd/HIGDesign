import Foundation

/// A single labeled value for HIG chart components.
public struct HIGChartPoint: Identifiable, Hashable, Sendable {
    public let id: String
    public let label: String
    public let value: Double

    /// Creates a chart point.
    /// - Parameters:
    ///   - label: Category label shown on the axis or legend.
    ///   - value: Numeric magnitude.
    ///   - id: Stable identity; defaults to `label`.
    public init(label: String, value: Double, id: String? = nil) {
        self.id = id ?? label
        self.label = label
        self.value = value
    }
}
