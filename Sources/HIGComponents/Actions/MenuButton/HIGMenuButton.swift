import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A secondary-styled button that presents a menu of actions.
public struct HIGMenuButton<MenuContent: View>: View {
    private let title: String
    private let systemImage: String?
    private let menuContent: MenuContent

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @State private var showsWatchMenu = false

    public init(
        _ title: String,
        systemImage: String? = nil,
        @ViewBuilder menu: () -> MenuContent
    ) {
        self.title = title
        self.systemImage = systemImage
        self.menuContent = menu()
    }

    public var body: some View {
        let tokens = theme.menuButton
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        #if os(watchOS)
        Button {
            showsWatchMenu = true
        } label: {
            menuLabel(tokens: tokens, minHeight: minHeight)
        }
        .sheet(isPresented: $showsWatchMenu) {
            NavigationStack {
                VStack(alignment: .leading, spacing: theme.spacing.item) {
                    menuContent
                }
                .padding()
                .navigationTitle(title)
            }
        }
        .disabled(!isEnabled)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
        #else
        Menu {
            menuContent
        } label: {
            menuLabel(tokens: tokens, minHeight: minHeight)
        }
        .disabled(!isEnabled)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
        #endif
    }

    @ViewBuilder
    private func menuLabel(tokens: any HIGMenuButtonTokens, minHeight: CGFloat) -> some View {
        HStack(spacing: theme.spacing.compactItem) {
            if let systemImage {
                Image(systemName: systemImage)
            }
            Text(title)
            Image(systemName: "chevron.down")
                .font(.caption.weight(.semibold))
                .foregroundStyle(theme.colors.labelSecondary)
        }
        .font(tokens.font)
        .foregroundStyle(theme.colors.accent)
        .frame(minHeight: minHeight)
        .padding(.horizontal, tokens.horizontalPadding)
        .background(theme.colors.fillPrimary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .opacity(isEnabled ? 1 : 0.55)
    }
}

#if DEBUG
#Preview("HIGMenuButton") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGMenuButton("Options", systemImage: "ellipsis.circle") {
            Button("Rename") {}
            Button("Duplicate") {}
            Divider()
            Button("Delete", role: .destructive) {}
        }
        .padding()
    }
}
#endif