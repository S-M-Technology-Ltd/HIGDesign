import SwiftUI

/// Placement mode for ``higShimmer(isActive:mode:)``.
public enum HIGShimmerMode: Sendable {
    case mask
    case overlay(blendMode: BlendMode = .sourceAtop)
    case background
}