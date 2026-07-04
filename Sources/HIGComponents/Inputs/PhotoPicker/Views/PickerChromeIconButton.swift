#if os(iOS)
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

enum PickerChromeButtonSizing {
    case toolbar
    case banner
}

/// Icon-only control styled like navigation bar toolbar buttons (liquid glass circle on iOS 26+).
struct PickerChromeIconButtonView: View {
    let systemImage: String
    let accessibilityLabel: String
    var accessibilityHint: String?
    var sizing: PickerChromeButtonSizing = .toolbar
    let action: () -> Void

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }

    private var iconPadding: EdgeInsets {
        switch sizing {
        case .toolbar:
            let inset = tokens.toolbarChromeInset
            return EdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        case .banner:
            let inset = tokens.limitedBannerChromeButtonVerticalPadding
            return EdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        }
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(sizing == .banner ? .body.weight(.semibold) : .body)
                .imageScale(sizing == .banner ? .large : .medium)
                .padding(iconPadding)
        }
        .modifier(PickerChromeIconButtonViewStyle(sizing: sizing))
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint ?? "")
    }
}

/// Text + icon control styled like navigation bar toolbar buttons (liquid glass capsule on iOS 26+).
struct PickerChromeLabelButtonView: View {
    let title: String
    let systemImage: String
    var accessibilityHint: String?
    var sizing: PickerChromeButtonSizing = .toolbar
    let action: () -> Void

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }
    private var layout: PickerLayout { PickerLayout(tokens: tokens) }

    private var labelPadding: EdgeInsets {
        switch sizing {
        case .toolbar:
            let inset = tokens.toolbarChromeInset
            return EdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        case .banner:
            let horizontal = tokens.limitedBannerChromeButtonHorizontalPadding
            return EdgeInsets(top: 0, leading: horizontal, bottom: 0, trailing: horizontal)
        }
    }

    var body: some View {
        Button(action: action) {
            Label {
                Text(title)
                    .font(.caption.weight(.semibold))
                    .lineLimit(1)
            } icon: {
                Image(systemName: systemImage)
                    .font(.caption.weight(.semibold))
                    .imageScale(sizing == .banner ? .large : .small)
            }
            .padding(labelPadding)
            .frame(height: sizing == .banner ? tokens.limitedBannerChromeButtonHeight : nil)
        }
        .modifier(PickerChromeLabelButtonViewStyle(sizing: sizing))
        .padding(sizing == .banner ? layout.limitedBannerChromeBleedInsetInsets : EdgeInsets())
        .accessibilityLabel(title)
        .accessibilityHint(accessibilityHint ?? "")
    }
}

private enum PickerChromeButtonStyleSupport {
    @MainActor
    static func applyIconStyle<Content: View>(
        to content: Content,
        sizing: PickerChromeButtonSizing
    ) -> AnyView {
        let controlSize: ControlSize = sizing == .banner ? .small : .mini

        return AnyView(
            content
                .buttonStyle(.bordered)
                .controlSize(controlSize)
                .buttonBorderShape(.circle)
                .labelStyle(.iconOnly)
        )
    }

    @MainActor
    static func applyLabelStyle<Content: View>(
        to content: Content,
        sizing: PickerChromeButtonSizing
    ) -> AnyView {
        let controlSize: ControlSize = sizing == .banner ? .mini : .small

        return AnyView(
            content
                .buttonStyle(.bordered)
                .controlSize(controlSize)
                .buttonBorderShape(.capsule)
                .labelStyle(.titleAndIcon)
        )
    }
}

private struct PickerChromeIconButtonViewStyle: ViewModifier {
    let sizing: PickerChromeButtonSizing

    @MainActor
    func body(content: Content) -> some View {
        PickerChromeButtonStyleSupport.applyIconStyle(to: content, sizing: sizing)
    }
}

private struct PickerChromeLabelButtonViewStyle: ViewModifier {
    let sizing: PickerChromeButtonSizing

    @MainActor
    func body(content: Content) -> some View {
        PickerChromeButtonStyleSupport.applyLabelStyle(to: content, sizing: sizing)
    }
}

#if DEBUG
#Preview("Banner Chrome Buttons") {
    let tokens = HIGSystemPhotoPickerTokens()
    HStack(alignment: .center, spacing: tokens.albumListRowSpacing) {
        PickerChromeIconButtonView(
            systemImage: "chevron.down",
            accessibilityLabel: "Expand",
            sizing: .banner,
            action: {}
        )
        .frame(
            width: tokens.limitedBannerChromeButtonHeight,
            height: tokens.limitedBannerChromeButtonHeight
        )

        PickerChromeLabelButtonView(
            title: "Add more photos",
            systemImage: "photo.badge.plus",
            sizing: .banner,
            action: {}
        )
        .frame(height: tokens.limitedBannerChromeButtonHeight)
    }
    .padding()
    .background(tokens.chromeBackground)
}
#endif
#endif