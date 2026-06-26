import SwiftUI

/// Renders content with a Dynamic Type-scaled dimension derived from a base token value.
public struct HIGScaledDimension<Content: View>: View {
    private let baseValue: CGFloat
    private let relativeTo: Font.TextStyle
    private let content: (CGFloat) -> Content

    public init(
        baseValue: CGFloat,
        relativeTo: Font.TextStyle = .body,
        @ViewBuilder content: @escaping (CGFloat) -> Content
    ) {
        self.baseValue = baseValue
        self.relativeTo = relativeTo
        self.content = content
    }

    public var body: some View {
        HIGScaledDimensionBody(
            baseValue: baseValue,
            relativeTo: relativeTo,
            content: content
        )
    }
}

private struct HIGScaledDimensionBody<Content: View>: View {
    let baseValue: CGFloat
    let relativeTo: Font.TextStyle
    let content: (CGFloat) -> Content

    @ScaledMetric private var scaledValue: CGFloat

    init(
        baseValue: CGFloat,
        relativeTo: Font.TextStyle,
        @ViewBuilder content: @escaping (CGFloat) -> Content
    ) {
        self.baseValue = baseValue
        self.relativeTo = relativeTo
        self.content = content
        _scaledValue = ScaledMetric(wrappedValue: baseValue, relativeTo: relativeTo)
    }

    var body: some View {
        content(scaledValue)
    }
}