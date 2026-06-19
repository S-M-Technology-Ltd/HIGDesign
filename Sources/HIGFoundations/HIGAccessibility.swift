import CoreGraphics
import SwiftUI

public enum HIGAccessibility {
    public static let defaultMinimumTouchTarget: CGFloat = 44
    public static let watchMinimumTouchTarget: CGFloat = 28
    public static let tvMinimumTouchTarget: CGFloat = 60
}

public struct HIGAccessibilityPreferences: Equatable {
    public let prefersReducedMotion: Bool
    public let prefersIncreasedContrast: Bool
    public let dynamicTypeSize: DynamicTypeSize

    public init(
        prefersReducedMotion: Bool,
        prefersIncreasedContrast: Bool,
        dynamicTypeSize: DynamicTypeSize
    ) {
        self.prefersReducedMotion = prefersReducedMotion
        self.prefersIncreasedContrast = prefersIncreasedContrast
        self.dynamicTypeSize = dynamicTypeSize
    }

    public init(environment: EnvironmentValues) {
        self.prefersReducedMotion = environment.accessibilityReduceMotion
        self.prefersIncreasedContrast = environment.colorSchemeContrast == .increased
        self.dynamicTypeSize = environment.dynamicTypeSize
    }
}