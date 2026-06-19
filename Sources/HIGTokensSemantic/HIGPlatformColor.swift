import SwiftUI

enum HIGPlatformColor {
    static var systemBackground: Color {
        #if os(macOS)
        Color(nsColor: .windowBackgroundColor)
        #elseif os(iOS) || os(visionOS)
        Color(uiColor: .systemBackground)
        #elseif os(tvOS)
        Color(uiColor: .black)
        #else
        Color.black
        #endif
    }

    static var secondarySystemBackground: Color {
        #if os(macOS)
        Color(nsColor: .controlBackgroundColor)
        #elseif os(iOS) || os(visionOS)
        Color(uiColor: .secondarySystemBackground)
        #elseif os(tvOS)
        Color(uiColor: .darkGray)
        #else
        Color(white: 0.12)
        #endif
    }

    static var tertiarySystemFill: Color {
        #if os(macOS)
        Color(nsColor: .quaternaryLabelColor).opacity(0.25)
        #elseif os(iOS) || os(visionOS)
        Color(uiColor: .tertiarySystemFill)
        #elseif os(tvOS)
        Color(uiColor: .gray).opacity(0.35)
        #else
        Color.gray.opacity(0.25)
        #endif
    }

    static var separator: Color {
        #if os(macOS)
        Color(nsColor: .separatorColor)
        #elseif os(iOS) || os(visionOS) || os(tvOS)
        Color(uiColor: .separator)
        #else
        Color.gray.opacity(0.4)
        #endif
    }
}