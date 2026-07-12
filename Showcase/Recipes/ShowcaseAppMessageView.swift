import HIGDesign
import SwiftUI

struct ShowcaseAppMessageView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .appMessage,
            code: """
            HIGPageHeader("Messages")
            HIGChatBubble("…", alignment: .leading)
            HIGChatBubble("…", alignment: .trailing)
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Messages",
                    subtitle: "Support chat thread using HIGChatBubble — no messaging backend."
                )
                VStack(spacing: theme.spacing.item) {
                    HIGChatBubble(
                        "Hi — I need help with the admin shell drawer on iPhone.",
                        author: "Alex Kim",
                        timestamp: "9:12 AM",
                        avatarInitials: "AK",
                        alignment: .leading
                    )
                    HIGChatBubble(
                        "Sure. Use HIGAdminShell with style .drawer on compact widths.",
                        author: "Support",
                        timestamp: "9:14 AM",
                        avatarInitials: "SU",
                        alignment: .trailing
                    )
                    HIGChatBubble(
                        "That fixed it. Thanks!",
                        author: "Alex Kim",
                        timestamp: "9:16 AM",
                        avatarInitials: "AK",
                        alignment: .leading
                    )
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcaseAppMessageView") {
    ShowcasePreviewContainer {
        ShowcaseAppMessageView()
    }
}
#endif
