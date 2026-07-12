import CoreGraphics

/// Snapshot canvas targets used for platform-specific showcase renders.
public enum ShowcaseSnapshotPlatform: String, CaseIterable, Sendable, Identifiable {
    case macos
    case ios
    case ipados
    case visionos
    case tvos
    case watchos

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .macos: "macOS"
        case .ios: "iOS"
        case .ipados: "iPadOS"
        case .visionos: "visionOS"
        case .tvos: "tvOS"
        case .watchos: "watchOS"
        }
    }

    public var canvasSize: CGSize {
        switch self {
        case .macos:
            CGSize(width: 1200, height: 800)
        case .ios:
            CGSize(width: 390, height: 844)
        case .ipados:
            CGSize(width: 820, height: 1180)
        case .visionos:
            CGSize(width: 900, height: 620)
        case .tvos:
            CGSize(width: 960, height: 540)
        case .watchos:
            CGSize(width: 198, height: 242)
        }
    }

    /// Top safe-area inset used when compositing into a device-frame snapshot.
    public var snapshotTopSafeAreaHeight: CGFloat {
        switch self {
        case .ios:
            54
        case .ipados:
            24
        case .macos:
            0
        case .visionos:
            28
        case .tvos:
            36
        case .watchos:
            18
        }
    }

    /// Navigation bar row height for simulated mobile snapshot chrome.
    public var snapshotNavigationBarHeight: CGFloat {
        switch self {
        case .watchos:
            32
        default:
            44
        }
    }
}

extension ShowcaseComponent {
    /// Components that already ship their own navigation or full-screen chrome.
    var usesBuiltInNavigationChrome: Bool {
        switch self {
        case .navigationBar, .tabBar, .toolbar, .sidebar, .photoPicker, .photoEditor:
            true
        default:
            false
        }
    }
}

extension ShowcaseComponent {
    private var usesFullHeightSnapshotCanvas: Bool {
        switch self {
        case .photoPicker, .photoEditor, .longTextEditor, .sidebar, .tabBar, .navigationBar, .toolbar, .list, .form, .textEditor:
            true
        default:
            false
        }
    }

    public func snapshotCanvasSize(for platform: ShowcaseSnapshotPlatform) -> CGSize {
        platform.canvasSize
    }

    var supportedSnapshotPlatforms: [ShowcaseSnapshotPlatform] {
        switch self {
        case .button, .textField, .toggle, .divider, .progressView, .card, .panel, .panelGroup, .counter, .widget, .rating, .breadcrumb, .pageHeader,
             .pagination, .tabs, .accordion, .steps, .pearlSteps, .timeline, .statusIndicator, .emptyState,
             .closeButton, .modal, .tooltip, .popover, .drawer, .confirmationDialog, .networkProgressBar,
             .buttonGroup, .menuToggle, .inputGroup, .fieldMessage, .datePicker, .timePicker, .select, .autocomplete, .tagInput, .dataTable, .toolbar,
             .alert, .toast, .navigationBar, .label, .badge, .activityIndicator, .matrixLoader,
             .list, .form,
             .checkbox, .radio, .secureField, .searchField, .picker, .icon, .avatar, .link,
             .bulletList, .textEditor, .stepper, .menuButton, .tag, .codeBlock, .carousel, .lightbox, .mediaRow, .hero, .listGroup, .barChart, .lineChart, .pieChart, .areaChart:
            ShowcaseSnapshotPlatform.allCases
        case .slider, .dropZone:
            [.macos, .ios, .ipados, .visionos]
        case .segmentedControl, .tabBar:
            [.macos, .ios, .ipados, .visionos, .tvos]
        case .sidebar, .adminShell:
            [.macos, .ios, .ipados, .visionos]
        case .photoPicker, .photoEditor:
            [.ios]
        case .longTextEditor:
            [.macos, .ios, .ipados, .visionos]
        }
    }
}