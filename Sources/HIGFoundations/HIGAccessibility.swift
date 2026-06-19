import CoreGraphics
import Foundation

#if canImport(SwiftUI)
import SwiftUI
#endif

public enum HIGAccessibility {
    public static let defaultMinimumTouchTarget: CGFloat = 44
    public static let watchMinimumTouchTarget: CGFloat = 28
    public static let tvMinimumTouchTarget: CGFloat = 60

    #if canImport(SwiftUI)
    @MainActor
    public static var prefersReducedMotion: Bool {
        #if os(macOS)
        NSWorkspace.shared.accessibilityDisplayShouldReduceMotion
        #elseif os(watchOS)
        false
        #else
        UIAccessibility.isReduceMotionEnabled
        #endif
    }

    @MainActor
    public static var prefersIncreasedContrast: Bool {
        #if os(macOS)
        NSWorkspace.shared.accessibilityDisplayShouldIncreaseContrast
        #elseif os(watchOS)
        false
        #else
        UIAccessibility.isDarkerSystemColorsEnabled
        #endif
    }
    #endif
}

#if canImport(SwiftUI)
#if os(macOS)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif
#endif