import HIGFoundations
import SwiftUI

private struct HIGThemeStorageKey: EnvironmentKey {
    static let defaultValue: (any HIGTheme)? = nil
}

private struct HIGHorizontalSizeClassKey: EnvironmentKey {
    static let defaultValue: HIGUserInterfaceSizeClass = .regular
}

private struct HIGVerticalSizeClassKey: EnvironmentKey {
    static let defaultValue: HIGUserInterfaceSizeClass = .regular
}

extension EnvironmentValues {
    public var higTheme: any HIGTheme {
        guard let theme = higThemeStorage else {
            preconditionFailure("HIGTheme is required. Wrap content in HIGThemeableView(theme:).")
        }
        return theme
    }

    var higThemeStorage: (any HIGTheme)? {
        get { self[HIGThemeStorageKey.self] }
        set { self[HIGThemeStorageKey.self] = newValue }
    }

    public var higHorizontalSizeClass: HIGUserInterfaceSizeClass {
        get { self[HIGHorizontalSizeClassKey.self] }
        set { self[HIGHorizontalSizeClassKey.self] = newValue }
    }

    public var higVerticalSizeClass: HIGUserInterfaceSizeClass {
        get { self[HIGVerticalSizeClassKey.self] }
        set { self[HIGVerticalSizeClassKey.self] = newValue }
    }
}