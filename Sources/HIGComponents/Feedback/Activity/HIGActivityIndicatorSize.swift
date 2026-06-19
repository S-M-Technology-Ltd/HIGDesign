import HIGFoundations
import HIGPlatform
import HIGTokensComponent
import SwiftUI

/// Relative size for ``HIGActivityIndicator``.
public enum HIGActivityIndicatorSize: Sendable {
    case small
    case medium
    case large

    func controlSize(for capabilities: HIGPlatformCapabilities) -> ControlSize {
        switch capabilities.idiom {
        case .watch:
            switch self {
            case .small:
                .mini
            case .medium:
                .small
            case .large:
                .regular
            }
        case .tv:
            switch self {
            case .small:
                .regular
            case .medium:
                .large
            case .large:
                .extraLarge
            }
        case .mac:
            switch self {
            case .small:
                .small
            case .medium:
                .regular
            case .large:
                .large
            }
        default:
            switch self {
            case .small:
                .small
            case .medium:
                .regular
            case .large:
                .large
            }
        }
    }

    func scale(for tokens: any HIGActivityIndicatorTokens) -> CGFloat {
        switch self {
        case .small:
            tokens.smallScale
        case .medium:
            tokens.mediumScale
        case .large:
            tokens.largeScale
        }
    }
}