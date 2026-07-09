import HIGDesign
import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

/// Full showcase split view for macOS platform snapshots with SwiftUI title bar chrome.
struct ShowcaseSnapshotPlatformCaptureView: View {
    @State private var selection: ShowcaseComponent?
    @State private var themeChoice: ShowcaseThemeChoice
    @State private var colorScheme: ColorScheme?
    @State private var dynamicTypeSizeChoice: ShowcaseDynamicTypeSizeChoice = .system
    @State private var iconSettings = ShowcaseIconSettings()

    let component: ShowcaseComponent
    let entryTheme: ShowcaseThemeChoice
    let entryColorScheme: ColorScheme
    let includeTitleBar: Bool

    init(
        component: ShowcaseComponent,
        themeChoice: ShowcaseThemeChoice,
        colorScheme: ColorScheme,
        includeTitleBar: Bool = true
    ) {
        self.component = component
        entryTheme = themeChoice
        entryColorScheme = colorScheme
        self.includeTitleBar = includeTitleBar
        _themeChoice = State(initialValue: themeChoice)
        _colorScheme = State(initialValue: colorScheme)
        _selection = State(initialValue: component)
    }

    var body: some View {
        VStack(spacing: 0) {
            if includeTitleBar {
                macTitleBar
            }

            ShowcaseCatalogView(
                selection: $selection,
                themeChoice: $themeChoice,
                colorScheme: $colorScheme,
                dynamicTypeSizeChoice: $dynamicTypeSizeChoice,
                iconSettings: $iconSettings
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color(nsColor: .windowBackgroundColor))
        .preferredColorScheme(entryColorScheme)
        .onAppear {
            selection = component
        }
    }

    private var macTitleBar: some View {
        ZStack {
            HStack(spacing: 8) {
                ShowcaseSnapshotMacTrafficLightsView()
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 14)

            Text(component.title)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.primary)
                .lineLimit(1)
        }
        .frame(height: 28)
        .background(Color(nsColor: .windowBackgroundColor))
    }
}

#Preview("ShowcaseSnapshotPlatformCaptureView") {
    ShowcaseSnapshotPlatformCaptureView(
        component: .button,
        themeChoice: .system,
        colorScheme: .light
    )
    .frame(width: 800, height: 500)
}

/// Red/yellow/green window controls shown in macOS platform snapshot chrome.
struct ShowcaseSnapshotMacTrafficLightsView: View {
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

#Preview("ShowcaseSnapshotMacTrafficLightsView") {
    ShowcaseSnapshotMacTrafficLightsView()
        .padding()
}