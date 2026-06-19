import Foundation

public enum ShowcaseComponent: String, CaseIterable, Identifiable, Sendable {
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
    case checkbox
    case radio
    case segmentedControl
    case slider
    case secureField
    case searchField
    case picker

    public var id: String { rawValue }

    public var title: String {
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
        case .checkbox: "Checkbox"
        case .radio: "Radio"
        case .segmentedControl: "Segmented Control"
        case .slider: "Slider"
        case .secureField: "Secure Field"
        case .searchField: "Search Field"
        case .picker: "Picker"
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
        case .checkbox: "Selection Controls"
        case .radio: "Selection Controls"
        case .segmentedControl: "Segmented Controls"
        case .slider: "Sliders"
        case .secureField: "Text Fields"
        case .searchField: "Searching"
        case .picker: "Pickers"
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
        case .alert: "Inline banners and modal confirmations with HIG button roles."
        case .toast: "Single toasts and queued transient status messages."
        case .sidebar: "Themed split-view navigation for regular-width layouts."
        case .navigationBar: "Composable navigation titles with leading and trailing actions."
        case .label: "Primary, secondary, and caption text pairings."
        case .badge: "Compact counts and short status metadata."
        case .activityIndicator: "Indeterminate loading spinners."
        case .list: "Grouped rows with themed backgrounds."
        case .form: "Sectioned form groups with headers and footers."
        case .checkbox: "Multi-select settings with checkbox styling."
        case .radio: "Mutually exclusive choices with radio affordances."
        case .segmentedControl: "Compact filters across a few related views."
        case .slider: "Bounded value selection with live value readout."
        case .secureField: "Masked entry for passwords and sensitive text."
        case .searchField: "Search input with icon affordance and clear labeling."
        case .picker: "Menu pickers for choosing one value from a list."
        }
    }

    var platforms: String {
        switch self {
        case .button, .textField, .toggle, .divider, .progressView, .card, .toolbar,
             .alert, .toast, .navigationBar, .label, .badge, .activityIndicator, .list, .form,
             .checkbox, .radio, .secureField, .searchField, .picker:
            "iOS, iPadOS, macOS, visionOS, tvOS, watchOS"
        case .slider:
            "iOS, iPadOS, macOS, visionOS"
        case .segmentedControl:
            "iOS, iPadOS, macOS, visionOS, tvOS"
        case .tabBar:
            "iOS, iPadOS, macOS, visionOS, tvOS"
        case .sidebar:
            "iOS, iPadOS, macOS, visionOS"
        }
    }

    var snapshotBasename: String { rawValue }
}