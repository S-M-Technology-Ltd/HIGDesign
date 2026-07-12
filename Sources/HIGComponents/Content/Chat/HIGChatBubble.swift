import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed chat message bubble for admin messaging and support threads.
///
/// Shows message text with optional author, timestamp, and avatar. Alignment
/// switches between incoming (leading) and outgoing (trailing) styles.
/// Inspired by Remark Admin chat widgets; chrome resolves from ``HIGTheme/chatBubble``.
public struct HIGChatBubble: View {
    private let message: String
    private let author: String?
    private let timestamp: String?
    private let avatarInitials: String?
    private let alignment: HIGChatBubbleAlignment

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a chat message bubble.
    /// - Parameters:
    ///   - message: Message body text.
    ///   - author: Optional display name above the bubble.
    ///   - timestamp: Optional time caption (for example `"8:30 AM"`).
    ///   - avatarInitials: Optional initials for a ``HIGAvatar`` beside the bubble.
    ///   - alignment: Incoming (`.leading`) or outgoing (`.trailing`).
    public init(
        _ message: String,
        author: String? = nil,
        timestamp: String? = nil,
        avatarInitials: String? = nil,
        alignment: HIGChatBubbleAlignment = .leading
    ) {
        self.message = message
        self.author = author
        self.timestamp = timestamp
        self.avatarInitials = avatarInitials
        self.alignment = alignment
    }

    public var body: some View {
        let tokens = theme.chatBubble

        HStack(alignment: .bottom, spacing: tokens.stackSpacing) {
            if alignment == .leading {
                avatarView
                bubbleColumn(tokens: tokens)
                Spacer(minLength: tokens.sideGutter)
            } else {
                Spacer(minLength: tokens.sideGutter)
                bubbleColumn(tokens: tokens)
                avatarView
            }
        }
        .frame(maxWidth: .infinity, alignment: alignment == .leading ? .leading : .trailing)
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabelText)
    }

    @ViewBuilder
    private var avatarView: some View {
        if let avatarInitials {
            HIGAvatar(avatarInitials)
                .accessibilityHidden(true)
        }
    }

    private func bubbleColumn(tokens: any HIGChatBubbleTokens) -> some View {
        VStack(
            alignment: alignment == .leading ? .leading : .trailing,
            spacing: tokens.metaSpacing
        ) {
            if let author {
                Text(author)
                    .font(tokens.authorFont)
                    .foregroundStyle(theme.colors.labelSecondary)
            }

            Text(message)
                .font(tokens.messageFont)
                .foregroundStyle(messageForeground)
                .multilineTextAlignment(alignment == .leading ? .leading : .trailing)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, tokens.contentPaddingHorizontal)
                .padding(.vertical, tokens.contentPaddingVertical)
                .background(messageBackground)
                .clipShape(
                    RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                )

            if let timestamp {
                Text(timestamp)
                    .font(tokens.timestampFont)
                    .foregroundStyle(theme.colors.labelSecondary)
            }
        }
        .frame(
            maxWidth: .infinity,
            alignment: alignment == .leading ? .leading : .trailing
        )
    }

    private var messageForeground: Color {
        switch alignment {
        case .leading:
            theme.colors.labelPrimary
        case .trailing:
            theme.colors.labelOnAccent
        }
    }

    private var messageBackground: Color {
        switch alignment {
        case .leading:
            theme.colors.fillPrimary
        case .trailing:
            theme.colors.accent
        }
    }

    private var accessibilityLabelText: String {
        var parts: [String] = []
        switch alignment {
        case .leading:
            parts.append("Incoming message")
        case .trailing:
            parts.append("Outgoing message")
        }
        if let author {
            parts.append("from \(author)")
        }
        parts.append(message)
        if let timestamp {
            parts.append(timestamp)
        }
        return parts.joined(separator: ". ")
    }
}

#if DEBUG
#Preview("HIGChatBubble") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: HIGSpacing.md.rawValue) {
            HIGChatBubble(
                "Hello. What can I do for you?",
                author: "June Lane",
                timestamp: "8:30 AM",
                avatarInitials: "JL",
                alignment: .trailing
            )
            HIGChatBubble(
                "I'm just looking around. Will you tell me something about yourself?",
                author: "Edward Fletcher",
                timestamp: "8:35 AM",
                avatarInitials: "EF",
                alignment: .leading
            )
        }
        .padding()
    }
}
#endif
