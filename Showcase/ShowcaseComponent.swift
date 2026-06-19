import Foundation

enum ShowcaseComponent: String, CaseIterable, Identifiable, Sendable {
    case button
    case textField
    case toggle
    case divider

    var id: String { rawValue }

    var title: String {
        switch self {
        case .button:
            "Button"
        case .textField:
            "Text Field"
        case .toggle:
            "Toggle"
        case .divider:
            "Divider"
        }
    }

    var higReference: String {
        switch self {
        case .button:
            "Buttons"
        case .textField:
            "Text Fields"
        case .toggle:
            "Toggles"
        case .divider:
            "Layout"
        }
    }

    var summary: String {
        switch self {
        case .button:
            "Primary, secondary, destructive, and borderless actions."
        case .textField:
            "Single-line text entry with labeled captions."
        case .toggle:
            "Binary settings with platform-appropriate switch styling."
        case .divider:
            "Theme-backed separators for grouped content."
        }
    }

    var platforms: String {
        switch self {
        case .button, .textField, .toggle, .divider:
            "iOS, iPadOS, macOS, visionOS, tvOS, watchOS"
        }
    }
}