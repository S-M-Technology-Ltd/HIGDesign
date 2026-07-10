import Foundation

/// One step in a ``HIGSteps`` process trail.
public struct HIGStepsItem: Identifiable, Hashable, Sendable {
    public let id: String
    public let title: String
    public let detail: String?

    public init(id: String, title: String, detail: String? = nil) {
        self.id = id
        self.title = title
        self.detail = detail
    }

    /// Creates a step using the title as its identifier.
    public init(_ title: String, detail: String? = nil) {
        self.id = title
        self.title = title
        self.detail = detail
    }
}
