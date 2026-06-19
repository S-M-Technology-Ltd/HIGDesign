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
    case alert
    case toast
    case sidebar
    case navigationBar
    case label
    case badge
    case activityIndicator
    case list
    case form

    var id: String { rawValue }

    var title: String {
        switch self {
        case .button: "Button"
        case .textField: "Text Field"
        case .toggle: "Toggle"
        case .divider: "Divider"
        case .progressView: "Progress View"
        case .card: "Card"
        case .tabBar: "Tab Bar"
        case .toolbar: "Toolbar"
        case .alert: "Alert"
        case .toast: "Toast"
        case .sidebar: "Sidebar"
        case .navigationBar: "Navigation Bar"
        case .label: "Label"
        case .badge: "Badge"
        case .activityIndicator: "Activity Indicator"
        case .list: "List"
        case .form: "Form Section"
        }
    }

    var higReference: String {
        switch self {
        case .button: "Buttons"
        case .textField: "Text Fields"
        case .toggle: "Toggles"
        case .divider: "Layout"
        case .progressView: "Progress Indicators"
        case .card: "Layout"
        case .tabBar: "Tab Bars"
        case .toolbar: "Toolbars"
        case .alert: "Alerts"
        case .toast: "Component Notifications"
        case .sidebar: "Split Views"
        case .navigationBar: "Navigation Bars"
        case .label: "Labels"
        case .badge: "Labels"
        case .activityIndicator: "Loading"
        case .list: "Lists and Tables"
        case .form: "Settings"
        }
    }

    var summary: String {
        switch self {
        case .button: "Primary, secondary, destructive, and borderless actions."
        case .textField: "Single-line text entry with labeled captions."
        case .toggle: "Binary settings with platform-appropriate switch styling."
        case .divider: "Theme-backed separators for grouped content."
        case .progressView: "Determinate and indeterminate loading feedback."
        case .card: "Grouped surfaces for related settings and content."
        case .tabBar: "Top-level section navigation with themed tab items."
        case .toolbar: "Screen-level actions using native toolbar placements."
        case .alert: "Modal confirmations with destructive and cancel roles."
        case .toast: "Transient success and status messages."
        case .sidebar: "Split-view navigation for regular-width layouts."
        case .navigationBar: "Large and inline navigation title presentation."
        case .label: "Primary, secondary, and caption text pairings."
        case .badge: "Compact counts and short status metadata."
        case .activityIndicator: "Indeterminate loading spinners."
        case .list: "Grouped rows with themed backgrounds."
        case .form: "Sectioned form groups with headers and footers."
        }
    }

    var platforms: String {
        switch self {
        case .button, .textField, .toggle, .divider, .progressView, .card, .toolbar,
             .alert, .toast, .navigationBar, .label, .badge, .activityIndicator, .list, .form:
            "iOS, iPadOS, macOS, visionOS, tvOS, watchOS"
        case .tabBar:
            "iOS, iPadOS, macOS, visionOS, tvOS"
        case .sidebar:
            "iOS, iPadOS, macOS, visionOS"
        }
    }

    var snapshotBasename: String { rawValue }
}