import HIGThemesContract
import SwiftUI

extension View {
    /// Adds a token-backed shimmering effect, typically over ``redacted(reason: .placeholder)`` content.
    public func higShimmer(isActive: Bool = true, mode: HIGShimmerMode = .mask) -> some View {
        modifier(HIGShimmerModifier(isActive: isActive, mode: mode))
    }
}

private struct HIGShimmerModifier: ViewModifier {
    let isActive: Bool
    let mode: HIGShimmerMode

    @Environment(\.higTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.layoutDirection) private var layoutDirection
    @State private var isInitialState = true

    func body(content: Content) -> some View {
        if isActive, !reduceMotion {
            applyingShimmer(to: content)
                .animation(shimmerAnimation, value: isInitialState)
                .onAppear {
                    Task { @MainActor in
                        isInitialState = false
                    }
                }
        } else {
            content
        }
    }

    private var shimmerAnimation: Animation {
        let tokens = theme.shimmer
        return .linear(duration: tokens.animationDuration)
            .delay(tokens.animationDelay)
            .repeatForever(autoreverses: false)
    }

    @ViewBuilder
    private func applyingShimmer(to content: Content) -> some View {
        let gradient = LinearGradient(
            gradient: Gradient(colors: shimmerColors),
            startPoint: startPoint,
            endPoint: endPoint
        )

        switch mode {
        case .mask:
            content.mask(gradient)
        case let .overlay(blendMode):
            content.overlay(gradient.blendMode(blendMode))
        case .background:
            content.background(gradient)
        }
    }

    private var shimmerColors: [Color] {
        let tokens = theme.shimmer
        let base = theme.colors.fillPrimary
        return [
            base.opacity(tokens.baseOpacity),
            base.opacity(tokens.highlightOpacity),
            base.opacity(tokens.baseOpacity),
        ]
    }

    private var startPoint: UnitPoint {
        let band = theme.shimmer.bandSize
        let min = 0 - band
        let max = 1 + band
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: max, y: min) : UnitPoint(x: 0, y: 1)
        }
        return isInitialState ? UnitPoint(x: min, y: min) : UnitPoint(x: 1, y: 1)
    }

    private var endPoint: UnitPoint {
        let band = theme.shimmer.bandSize
        let min = 0 - band
        let max = 1 + band
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: 1, y: 0) : UnitPoint(x: min, y: max)
        }
        return isInitialState ? UnitPoint(x: 0, y: 0) : UnitPoint(x: max, y: max)
    }
}