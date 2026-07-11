import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A thin top-edge progress bar for page or network loading (nprogress role).
///
/// Use at the top of a screen or navigation container. Pass a `value` for determinate
/// progress, or omit it for an indeterminate pulse when `isActive`.
public struct HIGNetworkProgressBar: View {
    private let isActive: Bool
    private let value: Double?

    @Environment(\.higTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var indeterminatePhase = false

    /// Creates a network progress bar.
    /// - Parameters:
    ///   - isActive: When `false`, the bar is hidden.
    ///   - value: Optional 0...1 progress. `nil` uses an indeterminate animation.
    public init(isActive: Bool = true, value: Double? = nil) {
        self.isActive = isActive
        self.value = value
    }

    public var body: some View {
        let tokens = theme.networkProgressBar

        Group {
            if isActive {
                GeometryReader { proxy in
                    ZStack(alignment: .leading) {
                        theme.colors.fillPrimary
                            .frame(height: tokens.height)

                        accentFill(width: fillWidth(in: proxy.size.width, tokens: tokens), tokens: tokens)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
                .frame(height: tokens.height)
                .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
                .accessibilityElement()
                .accessibilityLabel("Loading")
                .accessibilityValue(accessibilityValue)
                .onAppear { startIndeterminateIfNeeded() }
                .onChange(of: isActive) { _, active in
                    if active {
                        startIndeterminateIfNeeded()
                    } else {
                        indeterminatePhase = false
                    }
                }
            }
        }
        .animation(reduceMotion ? nil : .easeInOut(duration: theme.motion.quick), value: isActive)
        .animation(reduceMotion ? nil : .easeInOut(duration: theme.motion.quick), value: value)
    }

    private var accessibilityValue: String {
        if let value {
            "\(Int(min(max(value, 0), 1) * 100)) percent"
        } else {
            "In progress"
        }
    }

    private func fillWidth(in total: CGFloat, tokens: any HIGNetworkProgressBarTokens) -> CGFloat {
        if let value {
            return total * min(max(value, 0), 1)
        }
        let band = total * tokens.indeterminateBandFraction
        return indeterminatePhase ? total : band
    }

    private func accentFill(width: CGFloat, tokens: any HIGNetworkProgressBarTokens) -> some View {
        theme.colors.accent
            .frame(width: max(width, tokens.height), height: tokens.height)
            .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
            .frame(maxWidth: .infinity, alignment: indeterminatePhase ? .trailing : .leading)
            .animation(
                reduceMotion || value != nil
                    ? nil
                    : .easeInOut(duration: theme.motion.emphasized).repeatForever(autoreverses: true),
                value: indeterminatePhase
            )
    }

    private func startIndeterminateIfNeeded() {
        guard isActive, value == nil, !reduceMotion else {
            indeterminatePhase = false
            return
        }
        indeterminatePhase = true
    }
}

#if DEBUG
#Preview("HIGNetworkProgressBar") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: 24) {
            HIGNetworkProgressBar(isActive: true)
            HIGNetworkProgressBar(isActive: true, value: 0.45)
            HIGNetworkProgressBar(isActive: false)
        }
        .padding()
    }
}
#endif
