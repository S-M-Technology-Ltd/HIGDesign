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
                ShowcaseSnapshotMacTrafficLights()

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

/// Red/yellow/green window controls shown in macOS platform snapshot chrome.
private struct ShowcaseSnapshotMacTrafficLights: View {
    private let diameter: CGFloat = 12
    private let spacing: CGFloat = 8

    var body: some View {
        HStack(spacing: spacing) {
            trafficLight(color: Color(red: 1.0, green: 0.37, blue: 0.34))
            trafficLight(color: Color(red: 1.0, green: 0.74, blue: 0.18))
            trafficLight(color: Color(red: 0.16, green: 0.78, blue: 0.25))
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Window controls")
    }

    private func trafficLight(color: Color) -> some View {
        Circle()
            .fill(color)
            .frame(width: diameter, height: diameter)
            .overlay {
                Circle()
                    .stroke(Color.black.opacity(0.12), lineWidth: 0.5)
            }
    }
}