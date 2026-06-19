import Foundation
import HIGTokensRaw

public protocol HIGMotionSemanticTokens: Sendable {
    var quick: TimeInterval { get }
    var standard: TimeInterval { get }
    var emphasized: TimeInterval { get }
}

public struct HIGSystemMotionSemanticTokens: HIGMotionSemanticTokens, Sendable {
    public let quick: TimeInterval
    public let standard: TimeInterval
    public let emphasized: TimeInterval

    public init(
        quick: TimeInterval = HIGMotion.quick.rawValue,
        standard: TimeInterval = HIGMotion.standard.rawValue,
        emphasized: TimeInterval = HIGMotion.emphasized.rawValue
    ) {
        self.quick = quick
        self.standard = standard
        self.emphasized = emphasized
    }
}