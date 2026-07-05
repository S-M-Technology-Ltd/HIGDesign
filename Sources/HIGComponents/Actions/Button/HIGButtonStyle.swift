import SwiftUI

/// Surface rendering style for ``HIGButton``.
public enum HIGButtonStyle: String, Sendable, CaseIterable {
    /// Token-backed filled, tinted, or borderless backgrounds.
    case standard
    /// Liquid-glass capsule on iOS 26+ and macOS 26+, with bordered fallback on earlier releases.
    case glass
}