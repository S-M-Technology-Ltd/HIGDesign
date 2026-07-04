#if os(iOS)
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

struct PhotoEditorToolbarView: View {
    let configuration: HIGPhotoEditorConfiguration
    let canReset: Bool
    let onCancel: () -> Void
    let onDone: () -> Void
    let onReset: () -> Void
    let onRotate: () -> Void
    let onAspectRatioSelected: (HIGPhotoEditorAspectRatio) -> Void

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoEditorTokens { theme.photoEditor }

    var body: some View {
        HStack(spacing: tokens.toolbarActionSpacing) {
            PhotoEditorChromeTextButtonView(
                title: configuration.localization.cancelTitle,
                accessibilityHint: "Dismisses the editor without saving changes.",
                action: onCancel
            )

            Spacer(minLength: tokens.toolbarActionSpacing)

            HStack(spacing: tokens.toolbarActionSpacing) {
                if configuration.showsResetButton {
                    PhotoEditorChromeIconButtonView(
                        systemImage: "arrow.counterclockwise",
                        accessibilityLabel: configuration.localization.resetTitle,
                        accessibilityHint: "Restores the original crop and zoom.",
                        action: onReset
                    )
                    .disabled(!canReset)
                    .opacity(canReset ? theme.opacity.full : theme.opacity.disabled)
                }

                if configuration.allowsRotation {
                    PhotoEditorChromeIconButtonView(
                        systemImage: "rotate.right",
                        accessibilityLabel: configuration.localization.rotateTitle,
                        accessibilityHint: "Rotates the image ninety degrees clockwise.",
                        action: onRotate
                    )
                }

                if configuration.allowsAspectRatioSelection, configuration.croppingStyle != .circular {
                    Menu {
                        ForEach(HIGPhotoEditorAspectRatio.allCases) { ratio in
                            Button(ratio.title) {
                                onAspectRatioSelected(ratio)
                            }
                        }
                    } label: {
                        Image(systemName: "aspectratio")
                            .font(.body)
                            .imageScale(.medium)
                            .padding(tokens.toolbarChromeInset)
                            .accessibilityLabel(configuration.localization.aspectRatioTitle)
                            .accessibilityHint("Changes the crop aspect ratio.")
                    }
                    .modifier(PhotoEditorChromeIconButtonStyle())
                }
            }

            Spacer(minLength: tokens.toolbarActionSpacing)

            PhotoEditorChromeTextButtonView(
                title: configuration.localization.doneTitle,
                accessibilityHint: "Applies the crop and finishes editing.",
                action: onDone
            )
        }
        .padding(.horizontal, tokens.toolbarHorizontalPadding)
        .padding(.vertical, tokens.toolbarVerticalPadding)
        .background(tokens.toolbarBackground)
    }
}
#endif