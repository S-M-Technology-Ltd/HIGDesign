import Foundation

/// Named “fun” silhouettes in the 112-loader catalog.
public enum HIGMatrixLoaderFun: String, CaseIterable, Sendable, Hashable {
    case heart
    case arrow
    case sparkle
    case eye
    case lightning
    case flower
    case wave
    case hexagon
    case ink
    case tokens
    case breathing
    case waveBend
    case snake
    case confetti
    case shimmer
    case pulseRing
    case cursor
    case star
}

/// Identifies one of the **112** clean-room dot-matrix loaders.
///
/// Catalog size matches the common multi-family layout (23 square + 20 circular +
/// 10 hex + 20 compact-3×3 + 20 triangle + 18 fun + 1 icon) with original HIGDesign
/// motion math — not a port of third-party loader source.
///
/// ```swift
/// HIGMatrixLoader(.square(3), size: .medium)
/// HIGMatrixLoader(.fun(.heart), size: .small)
/// HIGMatrixLoader(.icon)
/// ```
public enum HIGMatrixLoaderID: Hashable, Sendable {
    /// Square-family loaders. Valid indices: `1...23`.
    case square(Int)
    /// Circular-family loaders. Valid indices: `1...20`.
    case circular(Int)
    /// Hex-family loaders. Valid indices: `1...10`.
    case hex(Int)
    /// Compact 3×3 family. Valid indices: `1...20`.
    case grid3(Int)
    /// Triangle-family loaders. Valid indices: `1...20`.
    case triangle(Int)
    /// Fun silhouette family (18 loaders).
    case fun(HIGMatrixLoaderFun)
    /// Single icon-style loader.
    case icon

    /// Total loaders in the public catalog.
    public static let catalogCount = 112

    /// Every valid loader id in family order.
    public static var all: [HIGMatrixLoaderID] {
        var ids: [HIGMatrixLoaderID] = []
        ids += (1...23).map { .square($0) }
        ids += (1...20).map { .circular($0) }
        ids += (1...10).map { .hex($0) }
        ids += (1...20).map { .grid3($0) }
        ids += (1...20).map { .triangle($0) }
        ids += HIGMatrixLoaderFun.allCases.map { .fun($0) }
        ids.append(.icon)
        return ids
    }

    /// Stable zero-based index into ``all`` (`0..<catalogCount`).
    public var catalogIndex: Int {
        Self.all.firstIndex(of: self) ?? 0
    }

    /// Human-readable family + index label for showcase and debugging.
    public var displayName: String {
        switch self {
        case .square(let n): "Square \(n)"
        case .circular(let n): "Circular \(n)"
        case .hex(let n): "Hex \(n)"
        case .grid3(let n): "3×3 \(n)"
        case .triangle(let n): "Triangle \(n)"
        case .fun(let fun): "Fun \(fun.rawValue.capitalized)"
        case .icon: "Icon"
        }
    }

    /// Whether this id is inside the documented valid ranges.
    public var isValid: Bool {
        switch self {
        case .square(let n): (1...23).contains(n)
        case .circular(let n): (1...20).contains(n)
        case .hex(let n): (1...10).contains(n)
        case .grid3(let n): (1...20).contains(n)
        case .triangle(let n): (1...20).contains(n)
        case .fun, .icon: true
        }
    }

    /// Deterministically maps a seed onto one of the 112 loaders.
    public static func resolved(fromSeed seed: some Hashable) -> HIGMatrixLoaderID {
        var hasher = Hasher()
        hasher.combine(seed)
        let value = abs(hasher.finalize())
        let ids = all
        return ids[value % ids.count]
    }

    /// Clamp out-of-range family indices into the valid range.
    public func clamped() -> HIGMatrixLoaderID {
        switch self {
        case .square(let n):
            .square(min(max(n, 1), 23))
        case .circular(let n):
            .circular(min(max(n, 1), 20))
        case .hex(let n):
            .hex(min(max(n, 1), 10))
        case .grid3(let n):
            .grid3(min(max(n, 1), 20))
        case .triangle(let n):
            .triangle(min(max(n, 1), 20))
        case .fun, .icon:
            self
        }
    }
}
