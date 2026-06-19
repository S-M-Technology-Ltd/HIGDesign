import HIGThemesContract
import HIGTokensRaw
import SwiftUI

/// HIG-aligned progress indicator for determinate and indeterminate loading states.
public struct HIGProgressView: View {
    private let label: String?
    private let value: Double?

    @Environment(\.higTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(_ label: String? = nil, value: Double? = nil) {
        self.label = label
        self.value = value
    }

    public var body: some View {
        let tokens = theme.progress

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            if let label {
                Text(label)
                    .font(tokens.labelFont)
                    .foregroundStyle(theme.colors.labelSecondary)
            }

            if let value {
                ProgressView(value: min(max(value, 0), 1))
                    .tint(theme.colors.accent)
                    .animation(reduceMotion ? nil : .default, value: value)
                    .accessibilityValue("\(Int(value * 100)) percent")
            } else {
                ProgressView()
                    .tint(theme.colors.accent)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label ?? "Progress")
    }
}

#if DEBUG
#Preview("HIGProgressView") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(alignment: .leading, spacing: HIGSpacing.xl.rawValue) {
            HIGProgressView("Uploading")
            HIGProgressView("Installing", value: 0.62)
        }
        .padding()
    }
}
#endif