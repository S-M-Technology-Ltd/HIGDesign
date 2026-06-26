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