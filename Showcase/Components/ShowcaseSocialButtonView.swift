import HIGDesign
import SwiftUI

struct ShowcaseSocialButtonView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .socialButton)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGSocialButton(.apple) { /* … */ }
                    HIGSocialButton(.google) { /* … */ }
                    """) {
                        VStack(spacing: theme.spacing.item) {
                            HIGSocialButton(.apple) {}
                            HIGSocialButton(.google) {}
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGSocialButton(.linkedIn, style: .bordered) { /* … */ }
                    HIGSocialButton(.x, style: .bordered) { /* … */ }
                    """) {
                        VStack(spacing: theme.spacing.item) {
                            HIGSocialButton(.linkedIn, style: .bordered) {}
                            HIGSocialButton(.x, style: .bordered) {}
                        }
                    }

                    ShowcaseSampleView(code: """
                    HStack {
                        HIGSocialButton(.gitHub, style: .iconOnly) { /* … */ }
                        HIGSocialButton(.email, style: .iconOnly) { /* … */ }
                        HIGSocialButton(.website, style: .iconOnly) { /* … */ }
                    }
                    """) {
                        HStack(spacing: theme.spacing.item) {
                            HIGSocialButton(.gitHub, style: .iconOnly) {}
                            HIGSocialButton(.email, style: .iconOnly) {}
                            HIGSocialButton(.website, style: .iconOnly) {}
                            HIGSocialButton(.facebook, style: .iconOnly) {}
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Social Button")
    }
}

#if DEBUG
#Preview("ShowcaseSocialButtonView") {
    ShowcasePreviewContainer {
        ShowcaseSocialButtonView()
    }
}
#endif
