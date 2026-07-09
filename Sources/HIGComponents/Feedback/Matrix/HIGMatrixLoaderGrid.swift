import CoreGraphics
import Foundation

/// Clean-room opacity evaluation for the 112-loader catalog.
enum HIGMatrixLoaderGrid {
    static func cyclePhase(now: TimeInterval, cycleDuration: TimeInterval) -> Double {
        guard cycleDuration > 0 else { return 0 }
        let t = now.truncatingRemainder(dividingBy: cycleDuration) / cycleDuration
        return t < 0 ? t + 1 : t
    }

    static func pulse(distance: Double, phase: Double, width: Double) -> Double {
        let delta = abs(distance - phase)
        let wrapped = min(delta, 1 - delta)
        let normalized = max(0, 1 - wrapped / max(width, 0.05))
        return normalized * normalized
    }

    static func opacity(
        id: HIGMatrixLoaderID,
        row: Int,
        column: Int,
        phase: Double,
        base: Double,
        peak: Double,
        reduceMotion: Bool
    ) -> Double {
        let recipe = HIGMatrixLoaderRecipe.recipe(for: id)
        let n = recipe.gridCount
        guard row >= 0, column >= 0, row < n, column < n else { return 0 }
        guard isMasked(row: row, column: column, gridCount: n, kind: recipe.mask) else {
            return 0
        }

        if reduceMotion {
            return staticOpacity(
                recipe: recipe,
                row: row,
                column: column,
                base: base,
                peak: peak
            )
        }

        let amount = motionAmount(
            recipe: recipe,
            row: row,
            column: column,
            phase: phase
        )
        return base + (peak - base) * min(max(amount, 0), 1)
    }

    // MARK: - Masks

    static func isMasked(row: Int, column: Int, gridCount: Int, kind: HIGMatrixLoaderMaskKind) -> Bool {
        let n = gridCount
        let mid = n / 2
        let dx = column - mid
        let dy = row - mid
        let manhattan = abs(dx) + abs(dy)
        let chebyshev = max(abs(dx), abs(dy))
        let radius2 = dx * dx + dy * dy

        switch kind {
        case .full:
            return true
        case .circle:
            let maxR = Double(mid) + 0.35
            return Double(radius2) <= maxR * maxR
        case .diamond:
            return manhattan <= mid
        case .hex:
            return chebyshev <= mid && manhattan <= mid + mid / 2
        case .ring:
            let r = sqrt(Double(radius2))
            return abs(r - Double(mid) * 0.85) <= 1.15
        case .cross:
            return row == mid || column == mid
        case .corners:
            return (row == 0 || row == n - 1) && (column == 0 || column == n - 1)
        case .checker:
            return (row + column) % 2 == 0
        case .border:
            return row == 0 || column == 0 || row == n - 1 || column == n - 1
        case .plus:
            return row == mid || column == mid
        case .xShape:
            return row == column || row + column == n - 1
        case .triangle:
            // Staggered upright triangle on n×n (works for 5 and 7).
            let tip = 0
            let depth = row - tip
            guard depth >= 0, depth < n else { return false }
            let half = depth / 2
            return abs(column - mid) <= max(half, 0) && depth <= mid + mid / 2 + 1
        case .heart:
            // Compact 5×5 heart silhouette.
            let cells: Set<[Int]> = [
                [0, 1], [0, 3],
                [1, 0], [1, 1], [1, 2], [1, 3], [1, 4],
                [2, 0], [2, 1], [2, 2], [2, 3], [2, 4],
                [3, 1], [3, 2], [3, 3],
                [4, 2],
            ]
            return cells.contains([row, column])
        case .arrow:
            let cells: Set<[Int]> = [
                [0, 2],
                [1, 1], [1, 2], [1, 3],
                [2, 0], [2, 1], [2, 2], [2, 3], [2, 4],
                [3, 2],
                [4, 2],
            ]
            return cells.contains([row, column])
        case .sparkle:
            return row == mid || column == mid || row == column || row + column == n - 1
        case .eye:
            return (abs(dy) <= 1 && abs(dx) <= mid) || (row == mid && abs(dx) <= 1)
        case .lightning:
            let cells: Set<[Int]> = [
                [0, 2], [0, 3],
                [1, 2],
                [2, 1], [2, 2], [2, 3],
                [3, 2],
                [4, 1], [4, 2],
            ]
            return cells.contains([row, column])
        case .flower:
            return manhattan <= 1 || (abs(dx) == mid && dy == 0) || (abs(dy) == mid && dx == 0)
        case .waveShape:
            return abs(row - Int((sin(Double(column)) + 1) * Double(mid) / 2)) <= 1
                || abs(dy) <= 1
        case .hexagon:
            return chebyshev <= mid && manhattan <= mid + 1
        case .snake:
            // Snake path through rows.
            if row % 2 == 0 {
                return true
            }
            return column == (row % 4 == 1 ? n - 1 : 0)
        case .star:
            return row == mid || column == mid || abs(dx) == abs(dy)
        case .cursor:
            let cells: Set<[Int]> = [
                [0, 0], [1, 0], [2, 0], [3, 0],
                [1, 1], [2, 2], [3, 3],
                [3, 1], [4, 2],
            ]
            return cells.contains([row, column])
        }
    }

    // MARK: - Motion

    private static func motionAmount(
        recipe: HIGMatrixLoaderRecipe,
        row: Int,
        column: Int,
        phase: Double
    ) -> Double {
        let n = recipe.gridCount
        let maxIndex = Double(max(n - 1, 1))
        let rowNorm = Double(row) / maxIndex
        let colNorm = Double(column) / maxIndex
        let center = Double(n - 1) / 2
        let dx = Double(column) - center
        let dy = Double(row) - center
        let radius = sqrt(dx * dx + dy * dy)
        let maxRadius = max(sqrt(2 * center * center), 0.001)
        let radiusNorm = radius / maxRadius
        let angleNorm = (atan2(dy, dx) + .pi) / (2 * .pi)
        let index = row * n + column
        let cellCount = max(n * n, 1)

        switch recipe.motion {
        case .radialPulse(let width, let invert):
            let value = pulse(distance: radiusNorm, phase: phase, width: width)
            return invert ? 1 - value : value

        case .horizontalWave(let width, let reverse):
            let d = reverse ? 1 - colNorm : colNorm
            return pulse(distance: d, phase: phase, width: width)

        case .verticalWave(let width, let reverse):
            let d = reverse ? 1 - rowNorm : rowNorm
            return pulse(distance: d, phase: phase, width: width)

        case .diagonal(let anti, let width):
            let d = anti ? (rowNorm + (1 - colNorm)) / 2 : (rowNorm + colNorm) / 2
            return pulse(distance: d, phase: phase, width: width)

        case .scanColumn(let width):
            return max(0, 1 - abs(colNorm - phase) / width)

        case .scanRow(let width):
            return max(0, 1 - abs(rowNorm - phase) / width)

        case .orbit(let ringRadius, let width):
            let onRing = max(0, 1 - abs(radiusNorm - ringRadius) / 0.35)
            return onRing * pulse(distance: angleNorm, phase: phase, width: width)

        case .breathe:
            return 0.5 + 0.5 * sin(phase * 2 * .pi)

        case .rain(let stagger):
            let columnPhase = (colNorm * stagger + phase).truncatingRemainder(dividingBy: 1)
            return max(0, 1 - abs(rowNorm - columnPhase) / 0.28)

        case .spiral(let width):
            let spiral = (radiusNorm * 0.65 + angleNorm * 0.35)
                .truncatingRemainder(dividingBy: 1)
            return pulse(distance: spiral, phase: phase, width: width)

        case .sequential(let clockwise):
            let order = clockwise ? index : (cellCount - 1 - index)
            let pos = Double(order) / Double(cellCount)
            return pulse(distance: pos, phase: phase, width: 0.12)

        case .ripple(let fromCorner):
            let origin: (Double, Double) = {
                switch fromCorner % 4 {
                case 0: (0, 0)
                case 1: (0, maxIndex)
                case 2: (maxIndex, maxIndex)
                default: (maxIndex, 0)
                }
            }()
            let dist = sqrt(pow(Double(row) - origin.0, 2) + pow(Double(column) - origin.1, 2))
            let norm = dist / (maxRadius * Double(n) / max(center, 1))
            return pulse(distance: min(norm, 1), phase: phase, width: 0.28)

        case .pulseColumns(let phaseSpread):
            let p = (phase + colNorm * phaseSpread).truncatingRemainder(dividingBy: 1)
            return 0.5 + 0.5 * sin(p * 2 * .pi)

        case .pulseRows(let phaseSpread):
            let p = (phase + rowNorm * phaseSpread).truncatingRemainder(dividingBy: 1)
            return 0.5 + 0.5 * sin(p * 2 * .pi)

        case .checkerFlip:
            let odd = (row + column) % 2 == 0
            let wave = 0.5 + 0.5 * sin(phase * 2 * .pi)
            return odd ? wave : 1 - wave

        case .shimmer(let angle):
            let projected = (colNorm * cos(angle * 2 * .pi) + rowNorm * sin(angle * 2 * .pi) + 1) / 2
            return pulse(distance: projected, phase: phase, width: 0.22)

        case .confetti:
            // Pseudo-random sparkle per cell, stable in space, moving in time.
            let salt = Double((row * 17 + column * 31) % 97) / 97
            let t = (phase + salt).truncatingRemainder(dividingBy: 1)
            return t < 0.18 ? 1 : 0.15

        case .inkBleed:
            let edge = 1 - radiusNorm
            return pulse(distance: edge, phase: phase, width: 0.40)

        case .tokenFall:
            let lane = Double((column * 13) % 7) / 7
            let y = (phase + lane).truncatingRemainder(dividingBy: 1)
            return max(0, 1 - abs(rowNorm - y) / 0.22)

        case .snakeCrawl:
            // Follow a serpentine order.
            let serpentine: Int
            if row % 2 == 0 {
                serpentine = row * n + column
            } else {
                serpentine = row * n + (n - 1 - column)
            }
            let pos = Double(serpentine) / Double(cellCount)
            return pulse(distance: pos, phase: phase, width: 0.10)

        case .pulseRing:
            let band = abs(radiusNorm - (0.35 + 0.45 * phase))
            return max(0, 1 - band / 0.22)
        }
    }

    private static func staticOpacity(
        recipe: HIGMatrixLoaderRecipe,
        row: Int,
        column: Int,
        base: Double,
        peak: Double
    ) -> Double {
        guard recipe.idleHighlight else { return base }
        let n = recipe.gridCount
        let mid = n / 2
        let lit: Bool
        switch recipe.mask {
        case .cross, .plus:
            lit = row == mid || column == mid
        case .xShape, .sparkle, .star:
            lit = row == mid || column == mid || row == column
        case .ring, .circle, .hex, .hexagon, .diamond, .heart, .flower:
            lit = abs(row - mid) <= 1 && abs(column - mid) <= 1
        case .triangle:
            lit = row <= mid && abs(column - mid) <= 1
        case .border, .corners:
            lit = row == 0 || column == 0
        default:
            lit = row == mid && column == mid
        }
        return lit ? peak : base
    }
}
