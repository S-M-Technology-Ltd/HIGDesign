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
            CGSize(width: 900, height: 620)
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
        let base = platform.canvasSize
        guard !usesFullHeightSnapshotCanvas else { return base }

        let compactHeight = min(base.height, 520)
        return CGSize(width: base.width, height: compactHeight)
    }

    var supportedSnapshotPlatforms: [ShowcaseSnapshotPlatform] {
        switch self {
        case .button, .textField, .toggle, .divider, .progressView, .card, .toolbar,
             .alert, .toast, .navigationBar, .label, .badge, .activityIndicator, .list, .form,
             .checkbox, .radio, .secureField, .searchField, .picker, .icon, .avatar, .link,
             .bulletList, .textEditor, .stepper, .menuButton, .tag:
            ShowcaseSnapshotPlatform.allCases
        case .slider:
            [.macos, .ios, .ipados, .visionos]
        case .segmentedControl, .tabBar:
            [.macos, .ios, .ipados, .visionos, .tvos]
        case .sidebar:
            [.macos, .ios, .ipados, .visionos]
        case .photoPicker, .photoEditor:
            [.ios]
        case .longTextEditor:
            [.macos, .ios, .ipados, .visionos]
        }
    }
}