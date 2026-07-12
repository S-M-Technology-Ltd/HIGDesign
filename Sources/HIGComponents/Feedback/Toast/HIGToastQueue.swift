import Foundation
import Observation

/// Queues transient toast messages and presents them one at a time.
@MainActor
@Observable
public final class HIGToastQueue {
    /// Currently visible toast payload, if any.
    public private(set) var current: HIGToastItem?

    /// Message text of the current toast (compatibility accessor).
    public var currentMessage: String? { current?.message }

    public let configuration: HIGToastQueueConfiguration

    private struct PendingToast: Sendable {
        let item: HIGToastItem
        let duration: Duration
    }

    private var pending: [PendingToast] = []
    private var dismissTask: Task<Void, Never>?

    public init(configuration: HIGToastQueueConfiguration = .standard) {
        self.configuration = configuration
    }

    /// Adds a toast to the queue. Toasts display sequentially.
    public func enqueue(
        _ message: String,
        style: HIGToastStyle = .neutral,
        duration: Duration? = nil
    ) {
        enqueue(HIGToastItem(message, style: style), duration: duration)
    }

    /// Adds a toast item to the queue.
    public func enqueue(_ item: HIGToastItem, duration: Duration? = nil) {
        let resolvedDuration = duration ?? configuration.defaultDuration
        pending.append(PendingToast(item: item, duration: resolvedDuration))

        while pending.count > configuration.maximumQueuedMessages {
            pending.removeFirst()
        }

        presentNextIfIdle()
    }

    /// Dismisses the current toast and shows the next queued message, if any.
    public func dismissCurrent() {
        dismissTask?.cancel()
        dismissTask = nil
        current = nil
        presentNextIfIdle()
    }

    private func presentNextIfIdle() {
        guard current == nil, let next = pending.first else { return }
        pending.removeFirst()
        current = next.item

        dismissTask?.cancel()
        dismissTask = Task { @MainActor in
            try? await Task.sleep(for: next.duration)
            guard !Task.isCancelled, current == next.item else { return }
            dismissCurrent()
        }
    }
}
