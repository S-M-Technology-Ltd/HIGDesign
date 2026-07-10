import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGTimeline``.
public protocol HIGTimelineTokens: Sendable {
    var titleFont: Font { get }
    var detailFont: Font { get }
    var timestampFont: Font { get }
    var markerSize: CGFloat { get }
    var markerIconPointSize: CGFloat { get }
    var connectorWidth: CGFloat { get }
    var itemSpacing: CGFloat { get }
    var labelSpacing: CGFloat { get }
    var contentLeadingPadding: CGFloat { get }
}

/// System defaults for timeline surfaces.
public struct HIGSystemTimelineTokens: HIGTimelineTokens, Sendable {
    public let titleFont: Font
    public let detailFont: Font
    public let timestampFont: Font
    public let markerSize: CGFloat
    public let markerIconPointSize: CGFloat
    public let connectorWidth: CGFloat
    public let itemSpacing: CGFloat
    public let labelSpacing: CGFloat
    public let contentLeadingPadding: CGFloat

    public init(
        titleFont: Font = .headline,
        detailFont: Font = .subheadline,
        timestampFont: Font = .caption,
        markerSize: CGFloat = HIGSpacing.xl.rawValue,
        markerIconPointSize: CGFloat = HIGSpacing.sm.rawValue,
        connectorWidth: CGFloat = HIGBorder.hairline.rawValue + HIGSpacing.xxs.rawValue / 2,
        itemSpacing: CGFloat = HIGSpacing.md.rawValue,
        labelSpacing: CGFloat = HIGSpacing.xxs.rawValue,
        contentLeadingPadding: CGFloat = HIGSpacing.sm.rawValue
    ) {
        self.titleFont = titleFont
        self.detailFont = detailFont
        self.timestampFont = timestampFont
        self.markerSize = markerSize
        self.markerIconPointSize = markerIconPointSize
        self.connectorWidth = connectorWidth
        self.itemSpacing = itemSpacing
        self.labelSpacing = labelSpacing
        self.contentLeadingPadding = contentLeadingPadding
    }
}
