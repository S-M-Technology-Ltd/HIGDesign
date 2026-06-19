import SwiftUI

public protocol HIGTypographySemanticTokens: Sendable {
    var largeTitle: Font { get }
    var title: Font { get }
    var headline: Font { get }
    var body: Font { get }
    var callout: Font { get }
    var caption: Font { get }
    var button: Font { get }
}

public struct HIGSystemTypographySemanticTokens: HIGTypographySemanticTokens, Sendable {
    public let largeTitle: Font
    public let title: Font
    public let headline: Font
    public let body: Font
    public let callout: Font
    public let caption: Font
    public let button: Font

    public init(
        largeTitle: Font = .largeTitle,
        title: Font = .title2,
        headline: Font = .headline,
        body: Font = .body,
        callout: Font = .callout,
        caption: Font = .caption,
        button: Font = .body.weight(.semibold)
    ) {
        self.largeTitle = largeTitle
        self.title = title
        self.headline = headline
        self.body = body
        self.callout = callout
        self.caption = caption
        self.button = button
    }
}