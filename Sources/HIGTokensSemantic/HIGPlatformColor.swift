import SwiftUI

enum HIGPlatformColor {
    static var systemBackground: Color {
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

    static var secondarySystemBackground: Color {
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

    static var tertiarySystemFill: Color {
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

    static var separator: Color {
        #if os(macOS)
        Color(.separatorColor)
        #elseif os(iOS) || os(visionOS) || os(tvOS)
        Color(.separator)
        #else
        Color.gray.opacity(0.4)
        #endif
    }
}