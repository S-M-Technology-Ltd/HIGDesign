import HIGThemesContract
import SwiftUI

/// A themed text link that opens a URL.
public struct HIGLink: View {
    private let title: String
    private let url: URL

    @Environment(\.higTheme) private var theme
    @Environment(\.openURL) private var openURL

    public init(_ title: String, url: URL) {
        self.title = title
        self.url = url
    }

    public var body: some View {
        let tokens = theme.link

        Link(title, destination: url)
            .font(tokens.font)
            .foregroundStyle(theme.colors.accent)
            .accessibilityLabel(title)
    }
}

#if DEBUG
#Preview("HIGLink") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGLink("Human Interface Guidelines", url: URL(string: "https://developer.apple.com/design/human-interface-guidelines/")!)
            .padding()
    }
}
#endif