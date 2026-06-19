import CoreGraphics
import HIGFoundations

public struct HIGPlatformCapabilities: Sendable, Equatable {
    public let idiom: HIGUserInterfaceIdiom
    public let supportsPointer: Bool
    public let supportsFocusEngine: Bool
    public let supportsKeyboardShortcuts: Bool
    public let minimumTouchTarget: CGFloat

    public static var current: HIGPlatformCapabilities {
        #if os(macOS)
        HIGPlatformCapabilities(
            idiom: .mac,
            supportsPointer: true,
            supportsFocusEngine: false,
            supportsKeyboardShortcuts: true,
            minimumTouchTarget: HIGAccessibility.defaultMinimumTouchTarget
        )
        #elseif os(tvOS)
        HIGPlatformCapabilities(
            idiom: .tv,
            supportsPointer: false,
            supportsFocusEngine: true,
            supportsKeyboardShortcuts: false,
            minimumTouchTarget: HIGAccessibility.tvMinimumTouchTarget
        )
        #elseif os(watchOS)
        HIGPlatformCapabilities(
            idiom: .watch,
            supportsPointer: false,
            supportsFocusEngine: false,
            supportsKeyboardShortcuts: false,
            minimumTouchTarget: HIGAccessibility.watchMinimumTouchTarget
        )
        #elseif os(visionOS)
        HIGPlatformCapabilities(
            idiom: .vision,
            supportsPointer: true,
            supportsFocusEngine: false,
            supportsKeyboardShortcuts: false,
            minimumTouchTarget: HIGAccessibility.defaultMinimumTouchTarget
        )
        #elseif os(iOS)
        #if targetEnvironment(macCatalyst)
        HIGPlatformCapabilities(
            idiom: .mac,
            supportsPointer: true,
            supportsFocusEngine: false,
            supportsKeyboardShortcuts: true,
            minimumTouchTarget: HIGAccessibility.defaultMinimumTouchTarget
        )
        #else
        HIGPlatformCapabilities(
            idiom: .phone,
            supportsPointer: false,
            supportsFocusEngine: false,
            supportsKeyboardShortcuts: false,
            minimumTouchTarget: HIGAccessibility.defaultMinimumTouchTarget
        )
        #endif
        #else
        HIGPlatformCapabilities(
            idiom: .unknown,
            supportsPointer: false,
            supportsFocusEngine: false,
            supportsKeyboardShortcuts: false,
            minimumTouchTarget: HIGAccessibility.defaultMinimumTouchTarget
        )
        #endif
    }
}