import HIGDesign
import SwiftUI

struct ShowcaseAvatarView: View {
    @Environment(\.higTheme) private var theme
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .avatar)

                VStack(spacing: theme.spacing.item) {
                    ShowcaseSampleView(code: "HIGAvatar(\"AR\")") {
                        HIGAvatar("AR")
                    }
                    ShowcaseSampleView(code: "HIGAvatar(\"Sam\")") {
                        HIGAvatar("Sam")
                    }
                    ShowcaseSampleView(code: "HIGAvatar(\"\", systemImage: \"person.fill\")") {
                        HIGAvatar("", systemImage: "person.fill")
                    }
                    ShowcaseSampleView(code: "HIGAvatar(\"AR\", status: .online)") {
                        HStack(spacing: theme.spacing.item) {
                            HIGAvatar("AR", status: .online)
                            HIGAvatar("JD", status: .away)
                            HIGAvatar("", systemImage: "person.fill", status: .offline)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Avatar")
    }
}

#if DEBUG
#Preview("ShowcaseAvatarView") {
    ShowcasePreviewContainer {
        ShowcaseAvatarView()
    }
}
#endif