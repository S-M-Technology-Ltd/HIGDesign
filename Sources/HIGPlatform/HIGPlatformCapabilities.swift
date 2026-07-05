import CoreGraphics
import HIGFoundations

public struct HIGPlatformCapabilities: Sendable, Equatable {
    public let idiom: HIGUserInterfaceIdiom
    public let supportsPointer: Bool
    public let supportsFocusEngine: Bool
    public let supportsKeyboardShortcuts: Bool
    public let minimumTouchTarget: CGFloat

    public static var current: HIGPlatformCapabilities {
        if let idiom = HIGSnapshotPlatformOverride.idiom {
            return capabilities(for: idiom)
        }

        return hostCapabilities
    }

    private static var hostCapabilities: HIGPlatformCapabilities {
        #if os(macOS)
        return capabilities(for: .mac)
        #elseif os(tvOS)
        return capabilities(for: .tv)
        #elseif os(watchOS)
        return capabilities(for: .watch)
        #elseif os(visionOS)
        return capabilities(for: .vision)
        #elseif os(iOS)
        #if targetEnvironment(macCatalyst)
        return capabilities(for: .mac)
        #else
        return capabilities(for: .phone)
        #endif
        #else
        return capabilities(for: .unknown)
        #endif
    }

    public static func capabilities(for idiom: HIGUserInterfaceIdiom) -> HIGPlatformCapabilities {
        switch idiom {
        case .phone:
            return HIGPlatformCapabilities(
                idiom: .phone,
                supportsPointer: false,
                supportsFocusEngine: false,
                supportsKeyboardShortcuts: false,
                minimumTouchTarget: HIGAccessibility.defaultMinimumTouchTarget
            )
        case .pad:
            return HIGPlatformCapabilities(
                idiom: .pad,
                supportsPointer: false,
                supportsFocusEngine: false,
                supportsKeyboardShortcuts: false,
                minimumTouchTarget: HIGAccessibility.defaultMinimumTouchTarget
            )
        case .mac:
            return HIGPlatformCapabilities(
                idiom: .mac,
                supportsPointer: true,
                supportsFocusEngine: false,
                supportsKeyboardShortcuts: true,
                minimumTouchTarget: HIGAccessibility.defaultMinimumTouchTarget
            )
        case .tv:
            return HIGPlatformCapabilities(
                idiom: .tv,
                supportsPointer: false,
                supportsFocusEngine: true,
                supportsKeyboardShortcuts: false,
                minimumTouchTarget: HIGAccessibility.tvMinimumTouchTarget
            )
        case .watch:
            return HIGPlatformCapabilities(
                idiom: .watch,
                supportsPointer: false,
                supportsFocusEngine: false,
                supportsKeyboardShortcuts: false,
                minimumTouchTarget: HIGAccessibility.watchMinimumTouchTarget
            )
        case .vision:
            return HIGPlatformCapabilities(
                idiom: .vision,
                supportsPointer: true,
                supportsFocusEngine: false,
                supportsKeyboardShortcuts: false,
                minimumTouchTarget: HIGAccessibility.defaultMinimumTouchTarget
            )
        case .unknown:
            return HIGPlatformCapabilities(
                idiom: .unknown,
                supportsPointer: false,
                supportsFocusEngine: false,
                supportsKeyboardShortcuts: false,
                minimumTouchTarget: HIGAccessibility.defaultMinimumTouchTarget
            )
        }
    }
}