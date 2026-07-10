import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGPageHeader`` page chrome.
public protocol HIGPageHeaderTokens: Sendable {
    var titleFont: Font { get }
    var subtitleFont: Font { get }
    var stackSpacing: CGFloat { get }
    var breadcrumbSpacing: CGFloat { get }
}

/// System defaults for page headers.
public struct HIGSystemPageHeaderTokens: HIGPageHeaderTokens, Sendable {
    public let titleFont: Font
    public let subtitleFont: Font
    public let stackSpacing: CGFloat
    public let breadcrumbSpacing: CGFloat

    public init(
        titleFont: Font = .largeTitle.weight(.bold),
        subtitleFont: Font = .body,
        stackSpacing: CGFloat = HIGSpacing.sm.rawValue,
        breadcrumbSpacing: CGFloat = HIGSpacing.md.rawValue
    ) {
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
        self.stackSpacing = stackSpacing
        self.breadcrumbSpacing = breadcrumbSpacing
    }
}
