#if os(iOS)
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

struct PhotoEditorChromeIconButtonView: View {
    let systemImage: String
    let accessibilityLabel: String
    var accessibilityHint: String?
    let action: () -> Void

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoEditorTokens { theme.photoEditor }

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.body)
                .imageScale(.medium)
                .padding(tokens.toolbarChromeInset)
        }
        .modifier(PhotoEditorChromeIconButtonStyle())
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint ?? "")
    }
}

struct PhotoEditorChromeTextButtonView: View {
    let title: String
    let accessibilityHint: String?
    let action: () -> Void

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoEditorTokens { theme.photoEditor }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.body.weight(.semibold))
                .padding(tokens.toolbarChromeInset)
        }
        .modifier(PhotoEditorChromeTextButtonStyle())
        .accessibilityLabel(title)
        .accessibilityHint(accessibilityHint ?? "")
    }
}

private enum PhotoEditorChromeButtonStyleSupport {
    @MainActor
    static func applyIconStyle<Content: View>(to content: Content) -> AnyView {
        return AnyView(
            content
                .buttonStyle(.bordered)
                .controlSize(.mini)
                .buttonBorderShape(.circle)
                .labelStyle(.iconOnly)
        )
    }

    @MainActor
    static func applyTextStyle<Content: View>(to content: Content) -> AnyView {
        return AnyView(
            content
                .buttonStyle(.bordered)
                .controlSize(.small)
                .buttonBorderShape(.capsule)
        )
    }
}

struct PhotoEditorChromeIconButtonStyle: ViewModifier {
    @MainActor
    func body(content: Content) -> some View {
        PhotoEditorChromeButtonStyleSupport.applyIconStyle(to: content)
    }
}

private struct PhotoEditorChromeTextButtonStyle: ViewModifier {
    @MainActor
    func body(content: Content) -> some View {
        PhotoEditorChromeButtonStyleSupport.applyTextStyle(to: content)
    }
}
#endif