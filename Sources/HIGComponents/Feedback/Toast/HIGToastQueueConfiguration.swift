import Foundation

/// Configuration for sequential toast presentation and dismissal behavior.
public struct HIGToastQueueConfiguration: Sendable, Equatable {
    public var defaultDuration: Duration
    public var allowsManualDismissal: Bool
    public var maximumQueuedMessages: Int

    public init(
        defaultDuration: Duration = .seconds(2),
        allowsManualDismissal: Bool = false,
        maximumQueuedMessages: Int = 5
    ) {
        self.defaultDuration = defaultDuration
        self.allowsManualDismissal = allowsManualDismissal
        self.maximumQueuedMessages = max(1, maximumQueuedMessages)
    }

    /// Default sequential toasts with timed auto-dismiss.
    public static let standard = HIGToastQueueConfiguration()

    /// Longer display with an explicit dismiss affordance.
    public static let interactive = HIGToastQueueConfiguration(
        defaultDuration: .seconds(3),
        allowsManualDismissal: true,
        maximumQueuedMessages: 8
    )
}