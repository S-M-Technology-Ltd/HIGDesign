import HIGDesign
import SwiftUI

struct ShowcaseChatBubbleView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .chatBubble)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGChatBubble(
                        "Hello. What can I do for you?",
                        author: "June Lane",
                        timestamp: "8:30 AM",
                        avatarInitials: "JL",
                        alignment: .trailing
                    )
                    """) {
                        HIGChatBubble(
                            "Hello. What can I do for you?",
                            author: "June Lane",
                            timestamp: "8:30 AM",
                            avatarInitials: "JL",
                            alignment: .trailing
                        )
                    }

                    ShowcaseSampleView(code: """
                    HIGChatBubble(
                        "I'm just looking around.",
                        author: "Edward Fletcher",
                        timestamp: "8:35 AM",
                        avatarInitials: "EF",
                        alignment: .leading
                    )
                    """) {
                        HIGChatBubble(
                            "I'm just looking around. Will you tell me something about yourself?",
                            author: "Edward Fletcher",
                            timestamp: "8:35 AM",
                            avatarInitials: "EF",
                            alignment: .leading
                        )
                    }

                    ShowcaseSampleView(code: """
                    // Thread snippet
                    VStack {
                        HIGChatBubble("Where?", …, alignment: .trailing)
                        HIGChatBubble("You wait for notice.", …, alignment: .leading)
                    }
                    """) {
                        VStack(spacing: theme.spacing.item) {
                            HIGChatBubble(
                                "Where?",
                                author: "June Lane",
                                timestamp: "8:40 AM",
                                avatarInitials: "JL",
                                alignment: .trailing
                            )
                            HIGChatBubble(
                                "You wait for notice.",
                                author: "Edward Fletcher",
                                timestamp: "8:42 AM",
                                avatarInitials: "EF",
                                alignment: .leading
                            )
                            HIGChatBubble(
                                "OK, my name is Limingqiang. I like singing and basketball.",
                                author: "June Lane",
                                timestamp: "8:45 AM",
                                avatarInitials: "JL",
                                alignment: .trailing
                            )
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Chat Bubble")
    }
}

#if DEBUG
#Preview("ShowcaseChatBubbleView") {
    ShowcasePreviewContainer {
        ShowcaseChatBubbleView()
    }
}
#endif
