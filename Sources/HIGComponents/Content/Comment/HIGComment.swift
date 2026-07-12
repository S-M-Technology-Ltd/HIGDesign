import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed comment row for blogs, activity feeds, and admin discussion threads.
///
/// Shows author, body text, optional timestamp, avatar, and optional reply action.
/// Inspired by Remark Admin comments; chrome resolves from ``HIGTheme/comment``.
public struct HIGComment: View {
    private let author: String
    private let content: String
    private let timestamp: String?
    private let avatarInitials: String?
    private let replyTitle: String?
    private let onReply: (() -> Void)?
    private let showsSeparator: Bool

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a comment row.
    /// - Parameters:
    ///   - author: Display name of the commenter.
    ///   - body: Comment text content.
    ///   - timestamp: Optional relative or absolute time caption.
    ///   - avatarInitials: Optional initials for a leading ``HIGAvatar``.
    ///   - replyTitle: Optional reply control label (for example `"Reply"`).
    ///   - showsSeparator: When `true`, draws a bottom hairline for stacked lists.
    ///   - onReply: Handler for the reply control; required when `replyTitle` is set.
    public init(
        author: String,
        body: String,
        timestamp: String? = nil,
        avatarInitials: String? = nil,
        replyTitle: String? = nil,
        showsSeparator: Bool = true,
        onReply: (() -> Void)? = nil
    ) {
        self.author = author
        self.content = body
        self.timestamp = timestamp
        self.avatarInitials = avatarInitials
        self.replyTitle = replyTitle
        self.showsSeparator = showsSeparator
        self.onReply = onReply
    }

    public var body: some View {
        let tokens = theme.comment

        HStack(alignment: .top, spacing: tokens.avatarSpacing) {
            if let avatarInitials {
                HIGAvatar(avatarInitials)
                    .accessibilityHidden(true)
            }

            VStack(alignment: .leading, spacing: tokens.stackSpacing) {
                HStack(alignment: .firstTextBaseline, spacing: tokens.metaSpacing) {
                    Text(author)
                        .font(tokens.authorFont)
                        .foregroundStyle(theme.colors.labelPrimary)
                    if let timestamp {
                        Text(timestamp)
                            .font(tokens.timestampFont)
                            .foregroundStyle(theme.colors.labelSecondary)
                    }
                }

                Text(content)
                    .font(tokens.bodyFont)
                    .foregroundStyle(theme.colors.labelPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)

                if let replyTitle, let onReply {
                    Button(action: onReply) {
                        Text(replyTitle)
                            .font(tokens.actionFont)
                            .foregroundStyle(theme.colors.accent)
                    }
                    .buttonStyle(.plain)
                    .disabled(!isEnabled)
                    .accessibilityLabel("\(replyTitle) to \(author)")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, tokens.contentPaddingVertical)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .bottom) {
            if showsSeparator {
                Rectangle()
                    .fill(theme.colors.separator)
                    .frame(height: tokens.separatorWidth)
                    .accessibilityHidden(true)
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabelText)
    }

    private var accessibilityLabelText: String {
        var parts = ["Comment from \(author)", content]
        if let timestamp {
            parts.insert(timestamp, at: 1)
        }
        return parts.joined(separator: ". ")
    }
}

#if DEBUG
#Preview("HIGComment") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: HIGSpacing.none.rawValue) {
            HIGComment(
                author: "Herman Beck",
                body: "Great write-up. The token layering made our admin rebuild much cleaner.",
                timestamp: "2 hours ago",
                avatarInitials: "HB",
                replyTitle: "Reply"
            ) {}

            HIGComment(
                author: "Mary Adams",
                body: "Agreed — pairing this with HIGPanel keeps the feed scannable.",
                timestamp: "Just now",
                avatarInitials: "MA",
                showsSeparator: false
            )
        }
        .padding()
    }
}
#endif
