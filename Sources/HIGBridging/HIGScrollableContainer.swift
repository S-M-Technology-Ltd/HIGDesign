import SwiftUI

/// A cross-platform scroll container with consistent top-leading alignment.
public struct HIGScrollableContainer<Content: View>: View {
    private let showsIndicators: Bool
    private let content: Content

    public init(
        showsIndicators: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.showsIndicators = showsIndicators
        self.content = content()
    }

    public var body: some View {
        ScrollView(showsIndicators: showsIndicators) {
            content
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
    }
}

#if DEBUG
#Preview("HIGScrollableContainer") {
    HIGScrollableContainer {
        VStack(alignment: .leading, spacing: 8) {
            Text("First row")
            Text("Second row")
        }
        .padding()
    }
}
#endif