import CoreGraphics
import Foundation

/// Parses a subset of SVG path commands used by Heroicons.
enum HIGSVGPathParser {
    static func makePath(from data: String, in rect: CGRect, viewBoxSize: CGFloat = 24) -> CGPath {
        let scale = min(rect.width, rect.height) / viewBoxSize
        let offsetX = rect.midX - (viewBoxSize * scale / 2)
        let offsetY = rect.midY - (viewBoxSize * scale / 2)

        let path = CGMutablePath()
        var currentPoint = CGPoint.zero
        var startPoint = CGPoint.zero
        var previousCommand: Character?

        let tokens = tokenize(data)
        var index = 0

        func map(_ point: CGPoint) -> CGPoint {
            CGPoint(
                x: offsetX + point.x * scale,
                y: offsetY + point.y * scale
            )
        }

        func readNumber() -> CGFloat {
            let value = tokens[index]
            index += 1
            return CGFloat(Double(value) ?? 0)
        }

        while index < tokens.count {
            let token = tokens[index]
            index += 1

            let command: Character
            if token.count == 1, let character = token.first, character.isLetter {
                command = character
            } else if let previousCommand {
                command = previousCommand
                index -= 1
            } else {
                continue
            }

            previousCommand = command

            switch command {
            case "M":
                let point = map(CGPoint(x: readNumber(), y: readNumber()))
                path.move(to: point)
                currentPoint = point
                startPoint = point
            case "L":
                let point = map(CGPoint(x: readNumber(), y: readNumber()))
                path.addLine(to: point)
                currentPoint = point
            case "H":
                currentPoint = CGPoint(x: readNumber(), y: currentPoint.y)
                path.addLine(to: map(currentPoint))
            case "V":
                currentPoint = CGPoint(x: currentPoint.x, y: readNumber())
                path.addLine(to: map(currentPoint))
            case "C":
                let controlOne = map(CGPoint(x: readNumber(), y: readNumber()))
                let controlTwo = map(CGPoint(x: readNumber(), y: readNumber()))
                let endPoint = map(CGPoint(x: readNumber(), y: readNumber()))
                path.addCurve(to: endPoint, control1: controlOne, control2: controlTwo)
                currentPoint = endPoint
            case "Z":
                path.closeSubpath()
                currentPoint = startPoint
            default:
                break
            }
        }

        return path
    }

    private static func tokenize(_ data: String) -> [String] {
        var tokens: [String] = []
        var current = ""

        func flush() {
            guard !current.isEmpty else { return }
            tokens.append(current)
            current = ""
        }

        for character in data {
            if character.isLetter {
                flush()
                tokens.append(String(character))
            } else if character == "," || character == " " {
                flush()
            } else if character == "-" && !current.isEmpty {
                flush()
                current.append(character)
            } else {
                current.append(character)
            }
        }

        flush()
        return tokens
    }
}