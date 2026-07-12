import HIGDesign
import SwiftUI

struct ShowcaseAppForumView: View {
    @Environment(\.higTheme) private var theme

    private let activity = [
        HIGTimelineItem(
            id: "thread",
            title: "New thread: Shell layouts",
            detail: "Alex started a discussion in Product.",
            timestamp: "10:12 AM",
            systemImage: "bubble.left.and.bubble.right"
        ),
        HIGTimelineItem(
            id: "reply",
            title: "Reply from Sam",
            detail: "Suggested pairing HIGAdminShell with HIGPanel.",
            timestamp: "10:40 AM",
            systemImage: "arrowshape.turn.up.left"
        ),
        HIGTimelineItem(
            id: "badge",
            title: "Solved",
            detail: "Thread marked answered.",
            timestamp: "11:05 AM",
            systemImage: "checkmark.seal"
        ),
    ]

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .appForum,
            code: """
            HIGPageHeader("Forum")
            HIGComment(author: "…", body: "…")
            HIGTimeline(items: activity)
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Forum",
                    subtitle: "Discussion thread with comments, badges, and activity timeline."
                )
                HStack(spacing: theme.spacing.item) {
                    HIGBadge("Product", style: .accent)
                    HIGBadge("3 replies", style: .neutral)
                }
                HIGComment(
                    author: "Alex Kim",
                    body: "Which shell style should we default for dense admin tools?",
                    timestamp: "2 hours ago",
                    avatarInitials: "AK"
                )
                HIGComment(
                    author: "Sam Rivera",
                    body: "Start with sidebar on regular width and drawer on compact.",
                    timestamp: "1 hour ago",
                    avatarInitials: "SR",
                    replyTitle: "Reply"
                ) {}
                HIGPanel("Activity") {
                    HIGTimeline(items: activity)
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcaseAppForumView") {
    ShowcasePreviewContainer {
        ShowcaseAppForumView()
    }
}
#endif
