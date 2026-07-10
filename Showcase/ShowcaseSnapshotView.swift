import HIGThemesContract
import HIGDesign
import SwiftUI

/// Renders a single showcase component for theme snapshot capture.
public struct ShowcaseSnapshotView: View {
    public let component: ShowcaseComponent
    public let platform: ShowcaseSnapshotPlatform?

    @Environment(\.higTheme) private var theme

    public init(
        component: ShowcaseComponent,
        platform: ShowcaseSnapshotPlatform? = nil
    ) {
        self.component = component
        self.platform = platform
    }

    public var body: some View {
        themeSnapshotBody
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(theme.colors.backgroundPrimary)
    }

    private var themeSnapshotBody: some View {
        VStack(alignment: .leading, spacing: HIGSpacing.none.rawValue) {
            Text(component.title)
                .font(theme.typography.caption.weight(.semibold))
                .foregroundStyle(theme.colors.labelSecondary)
                .padding(.horizontal, theme.spacing.screenEdge)
                .padding(.top, theme.spacing.item)
                .accessibilityHidden(true)

            ShowcaseSnapshotCatalogDetailView(
                component: component,
                iconSettings: .constant(ShowcaseIconSettings())
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

#if DEBUG
#Preview("ShowcaseSnapshotView") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseSnapshotView(component: .button)
    }
}
#endif