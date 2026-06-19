#if os(iOS)
import HIGThemesContract
import SwiftUI

struct LoadingProgressView: View {
    let progress: Double
    let label: String

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }

    var body: some View {
        VStack(spacing: tokens.loadingProgressSpacing) {
            ProgressView(value: progress)
                .progressViewStyle(.linear)
                .tint(theme.colors.labelPrimary)
            Text(label)
                .font(.footnote)
                .foregroundStyle(theme.colors.labelSecondary)
        }
        .padding(tokens.loadingProgressPadding)
        .frame(maxWidth: tokens.loadingProgressMaxWidth)
        .background(
            .regularMaterial,
            in: RoundedRectangle(cornerRadius: tokens.loadingProgressCornerRadius, style: .continuous)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityValue("\(Int(progress * 100)) percent")
    }
}

#if DEBUG
#Preview("Downloading") {
    let tokens = HIGSystemPhotoPickerTokens()
    ZStack {
        tokens.previewBackground
        LoadingProgressView(progress: 0.42, label: "Downloading from iCloud…")
    }
}

#Preview("Complete") {
    let tokens = HIGSystemPhotoPickerTokens()
    ZStack {
        tokens.previewBackground
        LoadingProgressView(progress: 1, label: "Downloading from iCloud…")
    }
}
#endif
#endif