import Foundation

/// Layout style for ``HIGAdminShell``.
///
/// Maps to Remark Admin shell families. v1 ships ``sidebar`` (Remark **base**).
public enum HIGAdminShellStyle: String, Sendable, CaseIterable {
    /// Leading sidebar navigation with detail content (Remark base).
    case sidebar
}
