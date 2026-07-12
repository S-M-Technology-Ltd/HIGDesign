import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A themed customer testimonial card for admin marketing and social proof.
///
/// Shows a quote with author attribution, optional role, avatar initials, and
/// optional star rating. Inspired by Remark Admin testimonial widgets; chrome
/// resolves from ``HIGTheme/testimonial``.
public struct HIGTestimonial: View {
    private let quote: String
    private let author: String
    private let role: String?
    private let avatarInitials: String?
    private let rating: Int?

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a testimonial card.
    /// - Parameters:
    ///   - quote: Customer quote text.
    ///   - author: Display name of the author.
    ///   - role: Optional title or company line.
    ///   - avatarInitials: Optional initials for a leading ``HIGAvatar``.
    ///   - rating: Optional filled star count shown via ``HIGRating``.
    public init(
        quote: String,
        author: String,
        role: String? = nil,
        avatarInitials: String? = nil,
        rating: Int? = nil
    ) {
        self.quote = quote
        self.author = author
        self.role = role
        self.avatarInitials = avatarInitials
        self.rating = rating
    }

    public var body: some View {
        let tokens = theme.testimonial

        VStack(alignment: .leading, spacing: tokens.stackSpacing) {
            if let rating {
                HIGRating(value: rating)
            }

            Text("“\(quote)”")
                .font(tokens.quoteFont)
                .foregroundStyle(theme.colors.labelPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)

            HStack(alignment: .center, spacing: tokens.authorSpacing) {
                if let avatarInitials {
                    HIGAvatar(avatarInitials)
                }

                VStack(alignment: .leading, spacing: tokens.authorSpacing) {
                    Text(author)
                        .font(tokens.authorFont)
                        .foregroundStyle(theme.colors.labelPrimary)
                    if let role {
                        Text(role)
                            .font(tokens.roleFont)
                            .foregroundStyle(theme.colors.labelSecondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(tokens.contentPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabelText)
    }

    private var accessibilityLabelText: String {
        var parts = ["Testimonial from \(author)", quote]
        if let role {
            parts.insert(role, at: 1)
        }
        if let rating {
            parts.append("Rating \(rating) of 5")
        }
        return parts.joined(separator: ". ")
    }
}

#if DEBUG
#Preview("HIGTestimonial") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGTestimonial(
            quote: "HIGDesign made our admin rebuild feel native on every Apple platform.",
            author: "Alex Rivera",
            role: "Product Design Lead",
            avatarInitials: "AR",
            rating: 5
        )
        .padding()
    }
}
#endif
