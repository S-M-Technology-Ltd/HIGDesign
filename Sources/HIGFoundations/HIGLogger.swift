import Foundation
import os

public struct HIGLogger: Sendable {
    private static let logger = Logger(subsystem: "com.higdesign", category: "HIGDesign")
    private static let prefix = "[HIGDesign]"

    nonisolated(unsafe) public static var verbose = false

    public static func debug(_ message: String) {
        guard verbose else { return }
        #if DEBUG
        logger.debug("\(prefix, privacy: .public) \(message, privacy: .public)")
        #endif
    }

    public static func info(_ message: String) {
        logger.info("\(prefix, privacy: .public) \(message, privacy: .public)")
    }
}