import Foundation

/// Grid silhouette used by a recipe.
enum HIGMatrixLoaderMaskKind: Sendable {
    case full
    case circle
    case diamond
    case hex
    case ring
    case cross
    case corners
    case checker
    case border
    case plus
    case xShape
    case triangle
    case heart
    case arrow
    case sparkle
    case eye
    case lightning
    case flower
    case waveShape
    case hexagon
    case snake
    case star
    case cursor
}

/// Motion engine parameters (clean-room formulas).
enum HIGMatrixLoaderMotionKind: Sendable {
    case radialPulse(width: Double, invert: Bool)
    case horizontalWave(width: Double, reverse: Bool)
    case verticalWave(width: Double, reverse: Bool)
    case diagonal(anti: Bool, width: Double)
    case scanColumn(width: Double)
    case scanRow(width: Double)
    case orbit(ringRadius: Double, width: Double)
    case breathe
    case rain(stagger: Double)
    case spiral(width: Double)
    case sequential(clockwise: Bool)
    case ripple(fromCorner: Int)
    case pulseColumns(phaseSpread: Double)
    case pulseRows(phaseSpread: Double)
    case checkerFlip
    case shimmer(angle: Double)
    case confetti
    case inkBleed
    case tokenFall
    case snakeCrawl
    case pulseRing
}

/// Immutable recipe describing one of the 112 loaders.
struct HIGMatrixLoaderRecipe: Sendable {
    let gridCount: Int
    let mask: HIGMatrixLoaderMaskKind
    let motion: HIGMatrixLoaderMotionKind
    let idleHighlight: Bool

    static func recipe(for id: HIGMatrixLoaderID) -> HIGMatrixLoaderRecipe {
        let id = id.clamped()
        switch id {
        case .square(let n):
            return squareRecipe(n)
        case .circular(let n):
            return circularRecipe(n)
        case .hex(let n):
            return hexRecipe(n)
        case .grid3(let n):
            return grid3Recipe(n)
        case .triangle(let n):
            return triangleRecipe(n)
        case .fun(let fun):
            return funRecipe(fun)
        case .icon:
            return HIGMatrixLoaderRecipe(
                gridCount: 5,
                mask: .sparkle,
                motion: .orbit(ringRadius: 0.55, width: 0.22),
                idleHighlight: true
            )
        }
    }

    // MARK: - Families

    private static func squareRecipe(_ n: Int) -> HIGMatrixLoaderRecipe {
        // 23 distinct square-grid motions on a 5×5 full mask.
        let motions: [HIGMatrixLoaderMotionKind] = [
            .radialPulse(width: 0.40, invert: false), // 1
            .horizontalWave(width: 0.30, reverse: false), // 2
            .diagonal(anti: false, width: 0.28), // 3
            .scanColumn(width: 0.22), // 4
            .orbit(ringRadius: 0.72, width: 0.18), // 5
            .breathe, // 6
            .radialPulse(width: 0.35, invert: true), // 7 cross-like via invert
            .rain(stagger: 0.35), // 8
            .verticalWave(width: 0.30, reverse: false), // 9
            .diagonal(anti: true, width: 0.28), // 10
            .scanRow(width: 0.22), // 11
            .spiral(width: 0.20), // 12
            .sequential(clockwise: true), // 13
            .sequential(clockwise: false), // 14
            .ripple(fromCorner: 0), // 15
            .ripple(fromCorner: 1), // 16
            .ripple(fromCorner: 2), // 17
            .ripple(fromCorner: 3), // 18
            .pulseColumns(phaseSpread: 0.18), // 19
            .pulseRows(phaseSpread: 0.18), // 20
            .checkerFlip, // 21
            .shimmer(angle: 0.25), // 22
            .horizontalWave(width: 0.22, reverse: true), // 23
        ]
        let motion = motions[n - 1]
        let mask: HIGMatrixLoaderMaskKind
        switch n {
        case 7: mask = .cross
        case 21: mask = .checker
        case 22: mask = .border
        default: mask = .full
        }
        return HIGMatrixLoaderRecipe(gridCount: 5, mask: mask, motion: motion, idleHighlight: true)
    }

    private static func circularRecipe(_ n: Int) -> HIGMatrixLoaderRecipe {
        let motions: [HIGMatrixLoaderMotionKind] = [
            .radialPulse(width: 0.38, invert: false),
            .orbit(ringRadius: 0.65, width: 0.20),
            .orbit(ringRadius: 0.85, width: 0.16),
            .spiral(width: 0.18),
            .breathe,
            .scanColumn(width: 0.20),
            .scanRow(width: 0.20),
            .horizontalWave(width: 0.28, reverse: false),
            .verticalWave(width: 0.28, reverse: true),
            .diagonal(anti: false, width: 0.26),
            .diagonal(anti: true, width: 0.26),
            .rain(stagger: 0.40),
            .sequential(clockwise: true),
            .sequential(clockwise: false),
            .ripple(fromCorner: 0),
            .pulseRing,
            .shimmer(angle: 0.5),
            .radialPulse(width: 0.30, invert: true),
            .pulseColumns(phaseSpread: 0.22),
            .pulseRows(phaseSpread: 0.22),
        ]
        let mask: HIGMatrixLoaderMaskKind = (n % 4 == 0) ? .ring : .circle
        return HIGMatrixLoaderRecipe(
            gridCount: 5,
            mask: mask,
            motion: motions[n - 1],
            idleHighlight: true
        )
    }

    private static func hexRecipe(_ n: Int) -> HIGMatrixLoaderRecipe {
        let motions: [HIGMatrixLoaderMotionKind] = [
            .radialPulse(width: 0.36, invert: false),
            .orbit(ringRadius: 0.70, width: 0.18),
            .spiral(width: 0.20),
            .breathe,
            .sequential(clockwise: true),
            .sequential(clockwise: false),
            .diagonal(anti: false, width: 0.30),
            .rain(stagger: 0.30),
            .shimmer(angle: 0.33),
            .pulseRing,
        ]
        return HIGMatrixLoaderRecipe(
            gridCount: 5,
            mask: .hex,
            motion: motions[n - 1],
            idleHighlight: true
        )
    }

    private static func grid3Recipe(_ n: Int) -> HIGMatrixLoaderRecipe {
        let motions: [HIGMatrixLoaderMotionKind] = [
            .sequential(clockwise: true),
            .sequential(clockwise: false),
            .breathe,
            .radialPulse(width: 0.45, invert: false),
            .horizontalWave(width: 0.35, reverse: false),
            .verticalWave(width: 0.35, reverse: false),
            .diagonal(anti: false, width: 0.35),
            .diagonal(anti: true, width: 0.35),
            .scanColumn(width: 0.30),
            .scanRow(width: 0.30),
            .orbit(ringRadius: 0.80, width: 0.25),
            .rain(stagger: 0.45),
            .checkerFlip,
            .shimmer(angle: 0.4),
            .pulseColumns(phaseSpread: 0.30),
            .pulseRows(phaseSpread: 0.30),
            .ripple(fromCorner: 0),
            .ripple(fromCorner: 2),
            .spiral(width: 0.28),
            .radialPulse(width: 0.40, invert: true),
        ]
        let mask: HIGMatrixLoaderMaskKind
        switch n {
        case 13: mask = .checker
        case 11: mask = .ring
        default: mask = .full
        }
        return HIGMatrixLoaderRecipe(
            gridCount: 3,
            mask: mask,
            motion: motions[n - 1],
            idleHighlight: true
        )
    }

    private static func triangleRecipe(_ n: Int) -> HIGMatrixLoaderRecipe {
        let motions: [HIGMatrixLoaderMotionKind] = [
            .radialPulse(width: 0.40, invert: false),
            .scanRow(width: 0.25),
            .horizontalWave(width: 0.30, reverse: false),
            .verticalWave(width: 0.30, reverse: true),
            .diagonal(anti: false, width: 0.30),
            .diagonal(anti: true, width: 0.30),
            .rain(stagger: 0.35),
            .breathe,
            .sequential(clockwise: true),
            .sequential(clockwise: false),
            .spiral(width: 0.22),
            .orbit(ringRadius: 0.60, width: 0.20),
            .shimmer(angle: 0.2),
            .ripple(fromCorner: 0),
            .ripple(fromCorner: 1),
            .pulseColumns(phaseSpread: 0.20),
            .pulseRows(phaseSpread: 0.20),
            .scanColumn(width: 0.24),
            .radialPulse(width: 0.32, invert: true),
            .pulseRing,
        ]
        return HIGMatrixLoaderRecipe(
            gridCount: 7,
            mask: .triangle,
            motion: motions[n - 1],
            idleHighlight: true
        )
    }

    private static func funRecipe(_ fun: HIGMatrixLoaderFun) -> HIGMatrixLoaderRecipe {
        switch fun {
        case .heart:
            return .init(gridCount: 5, mask: .heart, motion: .breathe, idleHighlight: true)
        case .arrow:
            return .init(gridCount: 5, mask: .arrow, motion: .scanColumn(width: 0.28), idleHighlight: true)
        case .sparkle:
            return .init(gridCount: 5, mask: .sparkle, motion: .radialPulse(width: 0.35, invert: false), idleHighlight: true)
        case .eye:
            return .init(gridCount: 5, mask: .eye, motion: .breathe, idleHighlight: true)
        case .lightning:
            return .init(gridCount: 5, mask: .lightning, motion: .shimmer(angle: 0.15), idleHighlight: true)
        case .flower:
            return .init(gridCount: 5, mask: .flower, motion: .orbit(ringRadius: 0.55, width: 0.22), idleHighlight: true)
        case .wave:
            return .init(gridCount: 5, mask: .waveShape, motion: .horizontalWave(width: 0.28, reverse: false), idleHighlight: true)
        case .hexagon:
            return .init(gridCount: 5, mask: .hexagon, motion: .radialPulse(width: 0.34, invert: false), idleHighlight: true)
        case .ink:
            return .init(gridCount: 5, mask: .circle, motion: .inkBleed, idleHighlight: true)
        case .tokens:
            return .init(gridCount: 5, mask: .full, motion: .tokenFall, idleHighlight: true)
        case .breathing:
            return .init(gridCount: 5, mask: .diamond, motion: .breathe, idleHighlight: true)
        case .waveBend:
            return .init(gridCount: 5, mask: .waveShape, motion: .verticalWave(width: 0.26, reverse: true), idleHighlight: true)
        case .snake:
            return .init(gridCount: 5, mask: .snake, motion: .snakeCrawl, idleHighlight: true)
        case .confetti:
            return .init(gridCount: 5, mask: .full, motion: .confetti, idleHighlight: false)
        case .shimmer:
            return .init(gridCount: 5, mask: .border, motion: .shimmer(angle: 0.6), idleHighlight: true)
        case .pulseRing:
            return .init(gridCount: 5, mask: .ring, motion: .pulseRing, idleHighlight: true)
        case .cursor:
            return .init(gridCount: 5, mask: .cursor, motion: .scanRow(width: 0.30), idleHighlight: true)
        case .star:
            return .init(gridCount: 5, mask: .star, motion: .radialPulse(width: 0.32, invert: false), idleHighlight: true)
        }
    }
}
