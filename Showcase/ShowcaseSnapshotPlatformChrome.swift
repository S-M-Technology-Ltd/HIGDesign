import HIGDesign
import SwiftUI

/// Navigation chrome and safe-area layout for platform-specific showcase snapshots.
struct ShowcaseSnapshotPlatformChromeView<Content: View>: View {
    let component: ShowcaseComponent
    let platform: ShowcaseSnapshotPlatform
    @ViewBuilder let content: () -> Content

    @Environment(\.higTheme) private var theme

    var body: some View {
        VStack(spacing: 0) {
            safeAreaSpacer

            navigationBar

            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(theme.colors.backgroundPrimary)
    }

    private var safeAreaSpacer: some View {
        theme.colors.backgroundPrimary
            .frame(height: platform.snapshotTopSafeAreaHeight)
            .frame(maxWidth: .infinity)
            .accessibilityHidden(true)
    }

    @ViewBuilder
    private var navigationBar: some View {
        if platform == .macos {
            macNavigationBar
        } else {
            mobileNavigationBar
        }
    }

    private var mobileNavigationBar: some View {
        HStack(spacing: theme.spacing.compactItem) {
            Text(component.title)
                .font(theme.navigationBar.titleFont)
                .foregroundStyle(theme.colors.labelPrimary)
                .lineLimit(1)

            Spacer(minLength: 0)

            trailingAction
        }
        .padding(.horizontal, theme.spacing.screenEdge)
        .frame(height: platform.snapshotNavigationBarHeight)
        .background(theme.colors.backgroundPrimary)
    }

    private var macNavigationBar: some View {
        ZStack {
            HStack(spacing: theme.spacing.compactItem) {
                ShowcaseSnapshotMacTrafficLightsView()

                Spacer(minLength: 0)

                trailingAction
            }
            .padding(.horizontal, theme.spacing.screenEdge)

            Text(component.title)
                .font(theme.navigationBar.titleFont)
                .foregroundStyle(theme.colors.labelPrimary)
                .lineLimit(1)
        }
        .frame(height: platform.snapshotNavigationBarHeight)
        .background(theme.colors.backgroundPrimary)
    }

    private var trailingAction: some View {
        HIGNavigationBarIconAction(
            "square.and.arrow.up",
            accessibilityLabel: "Share"
        ) {}
    }
}