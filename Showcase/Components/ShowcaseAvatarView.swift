import HIGDesign
import SwiftUI

struct ShowcaseAvatarView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .avatar)

                HStack(spacing: 16) {
                    HIGAvatar("AR")
                    HIGAvatar("Sam")
                    HIGAvatar("", systemImage: "person.fill")
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Avatar")
    }
}

#if DEBUG
#Preview("ShowcaseAvatarView") {
    ShowcaseAvatarView()
}
#endif