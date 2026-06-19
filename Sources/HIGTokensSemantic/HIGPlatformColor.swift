import SwiftUI

public enum HIGPlatformColor {
    public static var systemBackground: Color {
        #if os(macOS)
        Color(.windowBackgroundColor)
        #elseif os(iOS) || os(visionOS)
        Color(.systemBackground)
        #elseif os(tvOS)
        Color.black
        #else
        Color.black
        #endif
    }

    public static var secondarySystemBackground: Color {
        #if os(macOS)
        Color(.controlBackgroundColor)
        #elseif os(iOS) || os(visionOS)
        Color(.secondarySystemBackground)
        #elseif os(tvOS)
        Color(white: 0.15)
        #else
        Color(white: 0.12)
        #endif
    }

    public static var tertiarySystemFill: Color {
        #if os(macOS)
        Color(.tertiarySystemFill)
        #elseif os(iOS) || os(visionOS)
        Color(.tertiarySystemFill)
        #elseif os(tvOS)
        Color.gray.opacity(0.35)
        #else
        Color.gray.opacity(0.25)
        #endif
    }

    public static var separator: Color {
        #if os(macOS)
        Color(.separatorColor)
        #elseif os(iOS) || os(visionOS) || os(tvOS)
        Color(.separator)
        #else
        Color.gray.opacity(0.4)
        #endif
    }

    public static var quaternarySystemFill: Color {
        #if os(macOS)
        Color(.quaternarySystemFill)
        #elseif os(iOS) || os(visionOS)
        Color(.quaternarySystemFill)
        #elseif os(tvOS)
        Color.gray.opacity(0.2)
        #else
        Color.gray.opacity(0.15)
        #endif
    }

    public static var systemGroupedBackground: Color {
        #if os(macOS)
        Color(.windowBackgroundColor)
        #elseif os(iOS) || os(visionOS)
        Color(.systemGroupedBackground)
        #elseif os(tvOS)
        Color(white: 0.1)
        #else
        Color(white: 0.08)
        #endif
    }

    public static var secondarySystemGroupedBackground: Color {
        #if os(macOS)
        Color(.controlBackgroundColor)
        #elseif os(iOS) || os(visionOS)
        Color(.secondarySystemGroupedBackground)
        #elseif os(tvOS)
        Color(white: 0.18)
        #else
        Color(white: 0.14)
        #endif
    }
}