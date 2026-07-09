import Foundation

/// Convenience aliases for common matrix loaders.
///
/// Prefer ``HIGMatrixLoaderID`` when you need the full 112-loader catalog.
/// These eight styles map to stable square-family entries for everyday use.
public enum HIGMatrixLoaderStyle: String, CaseIterable, Sendable, Hashable {
    /// Soft pulse expanding from the center cell.
    case pulse
    /// Horizontal wave sweeping left to right.
    case wave
    /// Diagonal sweep from top-leading to bottom-trailing.
    case diagonal
    /// Column scan moving across the grid.
    case scan
    /// Ring of cells orbiting the center.
    case orbit
    /// Full-grid brightness breathing in and out.
    case breathe
    /// Expanding cross through the mid row and column.
    case cross
    /// Soft rain falling down successive rows.
    case rain

    /// Catalog id backing this convenience style.
    public var loaderID: HIGMatrixLoaderID {
        switch self {
        case .pulse: .square(1)
        case .wave: .square(2)
        case .diagonal: .square(3)
        case .scan: .square(4)
        case .orbit: .square(5)
        case .breathe: .square(6)
        case .cross: .square(7)
        case .rain: .square(8)
        }
    }

    /// Deterministically maps a seed to a convenience style (stable across rebuilds).
    public static func resolved(fromSeed seed: some Hashable) -> HIGMatrixLoaderStyle {
        let styles = HIGMatrixLoaderStyle.allCases
        var hasher = Hasher()
        hasher.combine(seed)
        let value = abs(hasher.finalize())
        return styles[value % styles.count]
    }
}
