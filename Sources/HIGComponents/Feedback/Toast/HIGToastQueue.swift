import Foundation
import Observation

/// Queues transient toast messages and presents them one at a time.
@MainActor
@Observable
public final class HIGToastQueue {
    public private(set) var currentMessage: String?

    private struct PendingToast: Sendable {
        let message: String
        let duration: Duration
    }

    private var pending: [PendingToast] = []
    private var dismissTask: Task<Void, Never>?

    public init() {}

    /// Adds a toast to the queue. Toasts display sequentially.
    public func enqueue(_ message: String, duration: Duration = .seconds(2)) {
        pending.append(PendingToast(message: message, duration: duration))
        presentNextIfIdle()
    }

    /// Dismisses the current toast and shows the next queued message, if any.
    public func dismissCurrent() {
        dismissTask?.cancel()
        dismissTask = nil
        currentMessage = nil
        presentNextIfIdle()
    }

    private func presentNextIfIdle() {
        guard currentMessage == nil, let next = pending.first else { return }
        pending.removeFirst()
        currentMessage = next.message

        dismissTask?.cancel()
        dismissTask = Task { @MainActor in
            try? await Task.sleep(for: next.duration)
            guard !Task.isCancelled, currentMessage == next.message else { return }
            dismissCurrent()
        }
    }
}