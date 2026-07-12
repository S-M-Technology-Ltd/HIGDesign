import HIGDesign
import SwiftUI

struct ShowcaseCommentView: View {
    @Environment(\.higTheme) private var theme
    @State private var replyCount = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .comment)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGComment(
                        author: "Herman Beck",
                        body: "…",
                        timestamp: "2 hours ago",
                        avatarInitials: "HB"
                    )
                    """) {
                        HIGComment(
                            author: "Herman Beck",
                            body: "Great write-up. The token layering made our admin rebuild much cleaner.",
                            timestamp: "2 hours ago",
                            avatarInitials: "HB"
                        )
                    }

                    ShowcaseSampleView(code: """
                    HIGComment(
                        author: "Mary Adams",
                        body: "…",
                        timestamp: "Just now",
                        avatarInitials: "MA",
                        replyTitle: "Reply"
                    ) { /* … */ }
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGComment(
                                author: "Mary Adams",
                                body: "Agreed — pairing this with HIGPanel keeps the feed scannable.",
                                timestamp: "Just now",
                                avatarInitials: "MA",
                                replyTitle: "Reply",
                                showsSeparator: false
                            ) {
                                replyCount += 1
                            }
                            Text("Reply tapped: \(replyCount)")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    // Thread list
                    VStack {
                        HIGComment(author: "Caleb Richards", …)
                        HIGComment(author: "June Lane", …, showsSeparator: false)
                    }
                    """) {
                        VStack(spacing: HIGSpacing.none.rawValue) {
                            HIGComment(
                                author: "Caleb Richards",
                                body: "Can we get a nested reply style for support tickets?",
                                timestamp: "Yesterday",
                                avatarInitials: "CR",
                                replyTitle: "Reply"
                            ) {}

                            HIGComment(
                                author: "June Lane",
                                body: "Yes — indent nested HIGComment rows with theme spacing in the host list.",
                                timestamp: "5 hours ago",
                                avatarInitials: "JL",
                                replyTitle: "Reply",
                                showsSeparator: false
                            ) {}
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Comment")
    }
}

#if DEBUG
#Preview("ShowcaseCommentView") {
    ShowcasePreviewContainer {
        ShowcaseCommentView()
    }
}
#endif
