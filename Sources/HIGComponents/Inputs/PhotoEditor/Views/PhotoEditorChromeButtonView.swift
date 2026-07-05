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

struct PhotoEditorChromeIconButtonStyle: ViewModifier {
    @MainActor
    func body(content: Content) -> some View {
        PhotoChromeButtonStyleSupport.applyIconStyle(to: content, controlSize: .mini)
    }
}

private struct PhotoEditorChromeTextButtonStyle: ViewModifier {
    @MainActor
    func body(content: Content) -> some View {
        PhotoChromeButtonStyleSupport.applyCapsuleStyle(
            to: content,
            controlSize: .small,
            usesTitleAndIconLabel: false
        )
    }
}
#endif