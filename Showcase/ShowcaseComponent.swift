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
    case matrixLoader
    case list
    case form
    case checkbox
    case radio
    case segmentedControl
    case slider
    case secureField
    case searchField
    case picker
    case icon
    case avatar
    case link
    case bulletList
    case textEditor
    case stepper
    case menuButton
    case tag
    case photoPicker
    case photoEditor
    case longTextEditor
    case panel
    case breadcrumb
    case pageHeader

    public var id: String { rawValue }

    /// Components sorted A–Z by display title for the showcase catalog.
    public static var catalogSorted: [ShowcaseComponent] {
        allCases.sorted { lhs, rhs in
            lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
        }
    }

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
        case .matrixLoader: "Matrix Loader"
        case .list: "List"
        case .form: "Form Section"
        case .checkbox: "Checkbox"
        case .radio: "Radio"
        case .segmentedControl: "Segmented Control"
        case .slider: "Slider"
        case .secureField: "Secure Field"
        case .searchField: "Search Field"
        case .picker: "Picker"
        case .icon: "Icon"
        case .avatar: "Avatar"
        case .link: "Link"
        case .bulletList: "Bullet List"
        case .textEditor: "Text Editor"
        case .stepper: "Stepper"
        case .menuButton: "Menu Button"
        case .tag: "Tag"
        case .photoPicker: "Photo Picker"
        case .photoEditor: "Photo Editor"
        case .longTextEditor: "Long Text Editor"
        case .panel: "Panel"
        case .breadcrumb: "Breadcrumb"
        case .pageHeader: "Page Header"
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
        case .matrixLoader: "Loading"
        case .list: "Lists and Tables"
        case .form: "Settings"
        case .checkbox: "Selection Controls"
        case .radio: "Selection Controls"
        case .segmentedControl: "Segmented Controls"
        case .slider: "Sliders"
        case .secureField: "Text Fields"
        case .searchField: "Searching"
        case .picker: "Pickers"
        case .icon: "SF Symbols"
        case .avatar: "Images"
        case .link: "Links"
        case .bulletList: "Typography"
        case .textEditor: "Text Fields"
        case .stepper: "Steppers"
        case .menuButton: "Buttons"
        case .tag: "Labels"
        case .photoPicker: "Photo Picker"
        case .photoEditor: "Photo Editing"
        case .longTextEditor: "Rich Text Editing"
        case .panel: "Layout"
        case .breadcrumb: "Navigation"
        case .pageHeader: "Navigation"
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
        case .matrixLoader: "112 clean-room animated dot-matrix loading grids."
        case .list: "Grouped rows with themed backgrounds."
        case .form: "Sectioned form groups with headers and footers."
        case .checkbox: "Multi-select settings with checkbox styling."
        case .radio: "Mutually exclusive choices with radio affordances."
        case .segmentedControl: "Compact filters across a few related views."
        case .slider: "Bounded value selection with live value readout."
        case .secureField: "Masked entry for passwords and sensitive text."
        case .searchField: "Search input with icon affordance and clear labeling."
        case .picker: "Menu pickers for choosing one value from a list."
        case .icon: "Themed SF Symbols and Heroicons that scale with Dynamic Type."
        case .avatar: "Circular avatars with initials or fallback symbols."
        case .link: "Accent-colored text links that open URLs."
        case .bulletList: "Vertical bullet lists using HIG typography."
        case .textEditor: "Multi-line text entry with themed borders and backgrounds."
        case .stepper: "Integer steppers with labeled captions and bounded ranges."
        case .menuButton: "Secondary-styled buttons that present action menus."
        case .tag: "Pill-shaped chips for categories, filters, and metadata."
        case .photoPicker: "Photo library picker with album browsing, preview crop, and iCloud support."
        case .photoEditor: "Crop, rotate, and aspect-ratio editing inspired by TOCropViewController."
        case .longTextEditor: "Rich HTML long-form editing with formatting toolbar, inspired by swift-rich-html-editor."
        case .panel: "Admin content surface with title, actions, collapsible body, and footer."
        case .breadcrumb: "Hierarchical navigation trail with a non-interactive current segment."
        case .pageHeader: "Page title chrome with optional breadcrumb, subtitle, and trailing actions."
        }
    }

    var platforms: String {
        switch self {
        case .button, .textField, .toggle, .divider, .progressView, .card, .panel, .breadcrumb, .pageHeader, .toolbar,
             .alert, .toast, .navigationBar, .label, .badge, .activityIndicator, .matrixLoader,
             .list, .form,
             .checkbox, .radio, .secureField, .searchField, .picker, .icon, .avatar, .link,
             .bulletList, .textEditor, .stepper, .menuButton, .tag:
            "iOS, iPadOS, macOS, visionOS, tvOS, watchOS"
        case .slider:
            "iOS, iPadOS, macOS, visionOS"
        case .segmentedControl:
            "iOS, iPadOS, macOS, visionOS, tvOS"
        case .tabBar:
            "iOS, iPadOS, macOS, visionOS, tvOS"
        case .sidebar:
            "iOS, iPadOS, macOS, visionOS"
        case .photoPicker, .photoEditor:
            "iOS"
        case .longTextEditor:
            "iOS, iPadOS, macOS, visionOS"
        }
    }

    var snapshotBasename: String { rawValue }
}