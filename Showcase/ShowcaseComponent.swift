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
    case pagination
    case tabs
    case accordion
    case steps
    case pearlSteps
    case timeline
    case statusIndicator
    case emptyState
    case closeButton
    case modal
    case tooltip
    case popover
    case drawer
    case confirmationDialog
    case networkProgressBar
    case buttonGroup
    case menuToggle
    case inputGroup
    case fieldMessage
    case datePicker
    case timePicker
    case select
    case autocomplete
    case tagInput
    case dataTable
    case dropZone
    case adminShell
    case codeBlock
    case carousel
    case mediaRow
    case hero
    case listGroup
    case barChart
    case lineChart
    case pieChart
    case areaChart
    case lightbox
    case counter
    case widget
    case panelGroup
    case rating
    case testimonial
    case ribbon
    case pricingCard
    case chatBubble
    case comment
    case cover
    case imageOverlay
    case colorSelector
    case socialButton
    case imageFrame
    case treeView
    case reorderableList
    case calendar
    case dashboardGrid
    case videoPlayer
    case coachMark
    case map

    case appMailbox
    case appCalendar
    case appContacts
    case appDocuments
    case appForum
    case appLocation
    case appMedia
    case appMessage
    case appNotebook
    case appProjects
    case appTaskboard
    case appTravel
    case appWork

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
        case .counter: "Counter"
        case .widget: "Widget"
        case .panelGroup: "Panel Group"
        case .rating: "Rating"
        case .testimonial: "Testimonial"
        case .ribbon: "Ribbon"
        case .pricingCard: "Pricing Card"
        case .chatBubble: "Chat Bubble"
        case .comment: "Comment"
        case .cover: "Cover"
        case .imageOverlay: "Image Overlay"
        case .colorSelector: "Color Selector"
        case .socialButton: "Social Button"
        case .imageFrame: "Image Frame"
        case .treeView: "Tree View"
        case .reorderableList: "Reorderable List"
        case .calendar: "Calendar"
        case .dashboardGrid: "Dashboard Grid"
        case .videoPlayer: "Video Player"
        case .coachMark: "Coach Mark"
        case .map: "Map"
        case .appMailbox: "Mailbox App"
        case .appCalendar: "Calendar App"
        case .appContacts: "Contacts App"
        case .appDocuments: "Documents App"
        case .appForum: "Forum App"
        case .appLocation: "Location App"
        case .appMedia: "Media App"
        case .appMessage: "Message App"
        case .appNotebook: "Notebook App"
        case .appProjects: "Projects App"
        case .appTaskboard: "Taskboard App"
        case .appTravel: "Travel App"
        case .appWork: "Work App"
        case .breadcrumb: "Breadcrumb"
        case .pageHeader: "Page Header"
        case .pagination: "Pagination"
        case .tabs: "Tabs"
        case .accordion: "Accordion"
        case .steps: "Steps"
        case .pearlSteps: "Pearl Steps"
        case .timeline: "Timeline"
        case .statusIndicator: "Status Indicator"
        case .emptyState: "Empty State"
        case .closeButton: "Close Button"
        case .modal: "Modal"
        case .tooltip: "Tooltip"
        case .popover: "Popover"
        case .drawer: "Drawer"
        case .confirmationDialog: "Confirmation Dialog"
        case .networkProgressBar: "Network Progress Bar"
        case .buttonGroup: "Button Group"
        case .menuToggle: "Menu Toggle"
        case .inputGroup: "Input Group"
        case .fieldMessage: "Field Message"
        case .datePicker: "Date Picker"
        case .timePicker: "Time Picker"
        case .select: "Select"
        case .autocomplete: "Autocomplete"
        case .tagInput: "Tag Input"
        case .dataTable: "Data Table"
        case .dropZone: "Drop Zone"
        case .adminShell: "Admin Shell"
        case .codeBlock: "Code Block"
        case .carousel: "Carousel"
        case .mediaRow: "Media Row"
        case .hero: "Hero"
        case .listGroup: "List Group"
        case .barChart: "Bar Chart"
        case .lineChart: "Line Chart"
        case .pieChart: "Pie Chart"
        case .areaChart: "Area Chart"
        case .lightbox: "Lightbox"
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
        case .counter: "Layout"
        case .widget: "Layout"
        case .panelGroup: "Layout"
        case .rating: "Content"
        case .testimonial: "Content"
        case .ribbon: "Content"
        case .pricingCard: "Content"
        case .chatBubble: "Content"
        case .comment: "Content"
        case .cover: "Content"
        case .imageOverlay: "Content"
        case .colorSelector: "Inputs"
        case .socialButton: "Buttons"
        case .imageFrame: "Content"
        case .treeView: "Layout"
        case .reorderableList: "Layout"
        case .calendar: "Inputs"
        case .dashboardGrid: "Layout"
        case .videoPlayer: "Content"
        case .coachMark: "Tooltips"
        case .map: "Maps"
        case .appMailbox: "Lists and Tables"
        case .appCalendar: "Inputs"
        case .appContacts: "Lists and Tables"
        case .appDocuments: "File Management"
        case .appForum: "Content"
        case .appLocation: "Maps"
        case .appMedia: "Media"
        case .appMessage: "Content"
        case .appNotebook: "Text Fields"
        case .appProjects: "Navigation"
        case .appTaskboard: "Layout"
        case .appTravel: "Charts"
        case .appWork: "Charts"
        case .breadcrumb: "Navigation"
        case .pageHeader: "Navigation"
        case .pagination: "Navigation"
        case .tabs: "Navigation"
        case .accordion: "Layout"
        case .steps: "Navigation"
        case .pearlSteps: "Navigation"
        case .timeline: "Content"
        case .statusIndicator: "Content"
        case .emptyState: "Layout"
        case .closeButton: "Buttons"
        case .modal: "Modality"
        case .tooltip: "Tooltips"
        case .popover: "Popovers"
        case .drawer: "Navigation"
        case .confirmationDialog: "Alerts"
        case .networkProgressBar: "Progress Indicators"
        case .buttonGroup: "Buttons"
        case .menuToggle: "Buttons"
        case .inputGroup: "Text Fields"
        case .fieldMessage: "Text Fields"
        case .datePicker: "Pickers"
        case .timePicker: "Pickers"
        case .select: "Pickers"
        case .autocomplete: "Searching"
        case .tagInput: "Text Fields"
        case .dataTable: "Lists and Tables"
        case .dropZone: "File Management"
        case .adminShell: "Split Views"
        case .codeBlock: "Typography"
        case .carousel: "Layout"
        case .lightbox: "Media"
        case .mediaRow: "Layout"
        case .hero: "Layout"
        case .listGroup: "Lists and Tables"
        case .barChart: "Charts"
        case .lineChart: "Charts"
        case .pieChart: "Charts"
        case .areaChart: "Charts"
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
        case .pagination: "Page-number navigation with previous/next controls for long lists."
        case .tabs: "In-content tab labels with underline selection (not app tab bars)."
        case .accordion: "Expandable section stack for dense admin settings content."
        case .steps: "Numbered multi-step process trail with horizontal or vertical layout."
        case .pearlSteps: "Compact pearl/dot progress indicator for short wizards."
        case .timeline: "Vertical activity timeline with markers, connectors, and timestamps."
        case .statusIndicator: "Presence dots for online, away, busy, and offline states."
        case .emptyState: "Centered empty-content messaging with optional icon and actions."
        case .closeButton: "Standard dismiss control for modals, sheets, and panels."
        case .modal: "Themed modal chrome with title, close, body, and footer for sheet content."
        case .tooltip: "Helper tooltips via platform help and themed tooltip labels."
        case .popover: "Themed popover chrome presented with higPopover."
        case .drawer: "Slide-over detail panel with scrim presentation via higDrawer."
        case .confirmationDialog: "Native confirmation dialog presentation with HIG button roles."
        case .networkProgressBar: "Thin top-edge progress bar for page or network loading."
        case .buttonGroup: "Clustered action buttons with consistent spacing and optional equal widths."
        case .menuToggle: "Hamburger menu control that animates between open and closed states."
        case .inputGroup: "Text field chrome with leading and trailing adornments."
        case .fieldMessage: "Helper, error, and success messages under form fields."
        case .datePicker: "Labeled date selection with themed captions and platform-native styles."
        case .timePicker: "Labeled hour-and-minute selection with themed captions."
        case .select: "Form select with field chrome for single or multi selection."
        case .autocomplete: "Typeahead field that filters suggestions as you type."
        case .tagInput: "Freeform tag chips with type-to-add and optional suggestions."
        case .dataTable: "Columnar admin table with header, striping, and horizontal scroll."
        case .dropZone: "Browse and drop files into a themed upload surface."
        case .adminShell: "Admin app shell with brand chrome; six layout styles including drawer menu."
        case .codeBlock: "Monospaced code surface with optional language label and share."
        case .carousel: "Paged content carousel with themed indicators and optional auto-advance."
        case .mediaRow: "Media object row with leading media, title, subtitle, and trailing slot."
        case .hero: "Jumbotron-style hero with title, subtitle, and optional actions."
        case .listGroup: "Bordered list-group surface with selectable rows and optional header."
        case .barChart: "Vertical bar chart for categorical admin metrics via Swift Charts."
        case .lineChart: "Line chart for ordered admin trend series via Swift Charts."
        case .pieChart: "Pie or donut chart for part-to-whole admin metrics via Swift Charts."
        case .areaChart: "Filled area chart for ordered admin trend series via Swift Charts."
        case .lightbox: "Full-screen media gallery chrome with close, counter, and previous/next."
        case .counter: "Dashboard KPI tile with value, caption, optional icon, and trend."
        case .widget: "Dashboard widget surface that hosts counters, charts, or custom content."
        case .panelGroup: "Vertical stack of panels and widgets with shared group spacing."
        case .rating: "Star rating display and interactive selection for reviews."
        case .testimonial: "Customer quote card with author, optional role, avatar, and rating."
        case .ribbon: "Corner promo ribbon for NEW, SALE, and similar card markers."
        case .pricingCard: "Pricing plan card with price, features, CTA, and featured emphasis."
        case .chatBubble: "Incoming or outgoing chat message bubble with optional avatar and timestamp."
        case .comment: "Discussion comment row with author, body, timestamp, avatar, and reply."
        case .cover: "Cover banner with title, subtitle, scrim, and solid or custom background."
        case .imageOverlay: "Media figure with caption or custom panel overlay and optional scrim."
        case .colorSelector: "Circular color swatch selector for mutually exclusive color choices."
        case .socialButton: "Social and account action buttons with SF Symbols and semantic chrome."
        case .imageFrame: "Themed image container with aspect presets, border, and placeholder."
        case .treeView: "Hierarchical tree with expand, collapse, and optional selection."
        case .reorderableList: "Drag-to-reorder list for admin priority and section ordering."
        case .calendar: "Month grid calendar with day selection, navigation, and event marks."
        case .dashboardGrid: "Adaptive multi-column grid for dashboard widgets and counters."
        case .videoPlayer: "Themed video surface with optional title, caption, and placeholder."
        case .coachMark: "Onboarding coach mark with step progress, actions, and overlay helper."
        case .map: "MapKit admin map recipe composed with HIG widgets, panels, and list groups."
        case .appMailbox: "Mailbox app recipe: search, media rows, avatars, and badges."
        case .appCalendar: "Calendar app recipe: month grid, agenda panel, and event marks."
        case .appContacts: "Contacts app recipe: directory list, avatars, and profile panel."
        case .appDocuments: "Documents app recipe: drop zone and file data table."
        case .appForum: "Forum app recipe: comments, badges, and activity timeline."
        case .appLocation: "Location app recipe: site list paired with the Map catalog entry."
        case .appMedia: "Media library recipe: image frames in a dashboard grid."
        case .appMessage: "Messaging app recipe: chat bubble thread composition."
        case .appNotebook: "Notebook app recipe: note list and multi-line editor."
        case .appProjects: "Projects app recipe: steps, cards, and progress."
        case .appTaskboard: "Taskboard app recipe: kanban columns from HIGPanel stacks."
        case .appTravel: "Travel ops recipe: counters, widgets, and bar charts."
        case .appWork: "Work dashboard recipe: counters, widgets, and line charts."
        }
    }

    var platforms: String {
        switch self {
        case .button, .textField, .toggle, .divider, .progressView, .card, .panel, .panelGroup, .counter, .widget, .rating, .testimonial, .ribbon, .pricingCard, .chatBubble, .comment, .cover, .imageOverlay, .colorSelector, .socialButton, .imageFrame, .treeView, .reorderableList, .calendar, .dashboardGrid, .videoPlayer, .coachMark, .appMailbox, .appCalendar, .appContacts, .appDocuments, .appForum, .appLocation, .appMedia, .appMessage, .appNotebook, .appProjects, .appTaskboard, .appTravel, .appWork, .breadcrumb, .pageHeader,
             .pagination, .tabs, .accordion, .steps, .pearlSteps, .timeline, .statusIndicator, .emptyState,
             .closeButton, .modal, .tooltip, .popover, .drawer, .confirmationDialog, .networkProgressBar,
             .buttonGroup, .menuToggle, .inputGroup, .fieldMessage, .datePicker, .timePicker, .select, .autocomplete, .tagInput, .dataTable, .toolbar,
             .alert, .toast, .navigationBar, .label, .badge, .activityIndicator, .matrixLoader,
             .list, .form,
             .checkbox, .radio, .secureField, .searchField, .picker, .icon, .avatar, .link,
             .bulletList, .textEditor, .stepper, .menuButton, .tag, .codeBlock, .carousel, .lightbox, .mediaRow, .hero, .listGroup, .barChart, .lineChart, .pieChart, .areaChart:
            "iOS, iPadOS, macOS, visionOS, tvOS, watchOS"
        case .slider, .dropZone:
            "iOS, iPadOS, macOS, visionOS"
        case .segmentedControl:
            "iOS, iPadOS, macOS, visionOS, tvOS"
        case .tabBar:
            "iOS, iPadOS, macOS, visionOS, tvOS"
        case .sidebar, .adminShell:
            "iOS, iPadOS, macOS, visionOS"
        case .photoPicker, .photoEditor:
            "iOS"
        case .longTextEditor:
            "iOS, iPadOS, macOS, visionOS"
        case .map:
            "iOS, iPadOS, macOS, visionOS, watchOS"
        }
    }

    var snapshotBasename: String { rawValue }
}