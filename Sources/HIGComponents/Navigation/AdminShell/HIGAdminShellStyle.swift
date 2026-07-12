import Foundation

/// Layout style for ``HIGAdminShell``.
///
/// Maps to Remark Admin shell families.
public enum HIGAdminShellStyle: String, Sendable, CaseIterable {
    /// Leading labeled sidebar navigation with detail content (Remark **base**).
    case sidebar
    /// Narrow icon-only leading rail with detail content (Remark **iconbar**).
    case iconRail
    /// Top horizontal navigation strip with detail content below (Remark **topbar**).
    case topBar
    /// Top horizontal icon-only navigation strip with detail content below (Remark **topicon**).
    case topIcon
}
