import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A compact animated dot-matrix loading indicator.
///
/// Ships **112** clean-room patterns across square, circular, hex, 3×3, triangle,
/// fun, and icon families. Size, opacity, color, and motion resolve from theme tokens.
///
/// ```swift
/// HIGMatrixLoader(.square(3), size: .medium)
/// HIGMatrixLoader("Thinking…", style: .wave, size: .medium)
/// HIGMatrixLoader(seed: messageID, size: .small)
/// HIGMatrixLoader(.fun(.heart), size: .large)
/// ```
public struct HIGMatrixLoader: View {
    private let label: String?
    private let loaderID: HIGMatrixLoaderID
    private let size: HIGMatrixLoaderSize
    private let speedMultiplier: Double?

    @Environment(\.higTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// Creates a matrix loader from a catalog id (full 112-loader set).
    public init(
        _ id: HIGMatrixLoaderID,
        size: HIGMatrixLoaderSize = .medium,
        speed: Double? = nil
    ) {
        self.label = nil
        self.loaderID = id.clamped()
        self.size = size
        self.speedMultiplier = speed
    }

    /// Creates a labeled matrix loader from a catalog id.
    public init(
        _ label: String,
        id: HIGMatrixLoaderID,
        size: HIGMatrixLoaderSize = .medium,
        speed: Double? = nil
    ) {
        self.label = label
        self.loaderID = id.clamped()
        self.size = size
        self.speedMultiplier = speed
    }

    /// Creates a matrix loader with a convenience style (maps into the catalog).
    public init(
        style: HIGMatrixLoaderStyle = .pulse,
        size: HIGMatrixLoaderSize = .medium,
        speed: Double? = nil
    ) {
        self.label = nil
        self.loaderID = style.loaderID
        self.size = size
        self.speedMultiplier = speed
    }

    /// Creates a labeled matrix loader with a convenience style.
    public init(
        _ label: String,
        style: HIGMatrixLoaderStyle,
        size: HIGMatrixLoaderSize = .medium,
        speed: Double? = nil
    ) {
        self.label = label
        self.loaderID = style.loaderID
        self.size = size
        self.speedMultiplier = speed
    }

    /// Creates a matrix loader whose catalog id is derived deterministically from `seed`.
    ///
    /// Prefer this when many loaders appear in a list: the same seed always maps
    /// to the same loader, so cells do not reshuffle as SwiftUI rebuilds views.
    public init(
        seed: some Hashable,
        size: HIGMatrixLoaderSize = .medium,
        speed: Double? = nil
    ) {
        self.label = nil
        self.loaderID = HIGMatrixLoaderID.resolved(fromSeed: seed)
        self.size = size
        self.speedMultiplier = speed
    }

    /// Creates a labeled matrix loader whose catalog id is derived from `seed`.
    public init(
        _ label: String,
        seed: some Hashable,
        size: HIGMatrixLoaderSize = .medium,
        speed: Double? = nil
    ) {
        self.label = label
        self.loaderID = HIGMatrixLoaderID.resolved(fromSeed: seed)
        self.size = size
        self.speedMultiplier = speed
    }

    public var body: some View {
        let tokens = theme.matrixLoader
        let recipe = HIGMatrixLoaderRecipe.recipe(for: loaderID)
        let diameter = size.diameter(for: tokens)
        let color = theme.colors.accent
        let cycle = theme.motion.standard * tokens.cycleDurationMultiplier
        let safeSpeed = max(speedMultiplier ?? 1, 0.1)
        let cycleDuration = max(cycle / safeSpeed, 0.2)

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            if let label {
                Text(label)
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)
            }

            grid(
                recipe: recipe,
                diameter: diameter,
                color: color,
                cycleDuration: cycleDuration,
                base: tokens.baseOpacity,
                peak: tokens.peakOpacity,
                gapFraction: tokens.gapFraction
            )
            .frame(width: diameter, height: diameter)
            .accessibilityHidden(true)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label ?? "Loading")
        .accessibilityAddTraits(.updatesFrequently)
    }

    @ViewBuilder
    private func grid(
        recipe: HIGMatrixLoaderRecipe,
        diameter: CGFloat,
        color: Color,
        cycleDuration: TimeInterval,
        base: Double,
        peak: Double,
        gapFraction: CGFloat
    ) -> some View {
        let count = recipe.gridCount
        let cell = diameter / CGFloat(count)
        let dot = cell * (1 - gapFraction)
        let spacing = cell * gapFraction

        TimelineView(.animation(paused: reduceMotion)) { context in
            let now = context.date.timeIntervalSinceReferenceDate
            let phase = HIGMatrixLoaderGrid.cyclePhase(now: now, cycleDuration: cycleDuration)

            VStack(spacing: spacing) {
                ForEach(0..<count, id: \.self) { row in
                    HStack(spacing: spacing) {
                        ForEach(0..<count, id: \.self) { column in
                            Circle()
                                .fill(color)
                                .opacity(
                                    HIGMatrixLoaderGrid.opacity(
                                        id: loaderID,
                                        row: row,
                                        column: column,
                                        phase: phase,
                                        base: base,
                                        peak: peak,
                                        reduceMotion: reduceMotion
                                    )
                                )
                                .frame(width: dot, height: dot)
                        }
                    }
                }
            }
            .frame(width: diameter, height: diameter)
        }
    }
}

#if DEBUG
#Preview("HIGMatrixLoader — Pulse") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGMatrixLoader("Thinking…", style: .pulse, size: .large)
            .padding()
    }
}

#Preview("HIGMatrixLoader — Catalog sample") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 56))], spacing: 12) {
            ForEach(Array(HIGMatrixLoaderID.all.prefix(24)), id: \.self) { id in
                VStack(spacing: 4) {
                    HIGMatrixLoader(id, size: .small)
                    Text(id.displayName)
                        .font(.caption2)
                        .lineLimit(1)
                }
            }
        }
        .padding()
    }
}

#Preview("HIGMatrixLoader — Seeded") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HStack(spacing: 20) {
            HIGMatrixLoader(seed: "prep", size: .medium)
            HIGMatrixLoader(seed: "tools", size: .medium)
            HIGMatrixLoader(seed: "prep", size: .medium)
        }
        .padding()
    }
}
#endif
