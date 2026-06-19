import Foundation

enum ShowcaseComponent: String, CaseIterable, Identifiable, Sendable {
    case button
    case textField
    case toggle
    case divider
    case progressView
    case card
    case tabBar
    case toolbar

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
        case .progressView:
            "Progress View"
        case .card:
            "Card"
        case .tabBar:
            "Tab Bar"
        case .toolbar:
            "Toolbar"
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
        case .progressView:
            "Progress Indicators"
        case .card:
            "Layout"
        case .tabBar:
            "Tab Bars"
        case .toolbar:
            "Toolbars"
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
        case .progressView:
            "Determinate and indeterminate loading feedback."
        case .card:
            "Grouped surfaces for related settings and content."
        case .tabBar:
            "Top-level section navigation with themed tab items."
        case .toolbar:
            "Screen-level actions using native toolbar placements."
        }
    }

    var platforms: String {
        switch self {
        case .button, .textField, .toggle, .divider, .progressView, .card, .toolbar:
            "iOS, iPadOS, macOS, visionOS, tvOS, watchOS"
        case .tabBar:
            "iOS, iPadOS, macOS, visionOS, tvOS"
        }
    }
}