import HIGThemesContract
import SwiftUI

/// An indeterminate activity indicator with optional caption text.
public struct HIGActivityIndicator: View {
    private let label: String?
    private let size: HIGActivityIndicatorSize

    @Environment(\.higTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(_ label: String? = nil, size: HIGActivityIndicatorSize = .medium) {
        self.label = label
        self.size = size
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            if let label {
                Text(label)
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)
            }

            ProgressView()
                .controlSize(size.controlSize)
                .tint(theme.colors.accent)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label ?? "Loading")
    }
}

#if DEBUG
#Preview("HIGActivityIndicator") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(alignment: .leading, spacing: 20) {
            HIGActivityIndicator("Syncing")
            HIGActivityIndicator(size: .large)
        }
        .padding()
    }
}
#endif