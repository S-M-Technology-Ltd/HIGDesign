import HIGDesign
import SwiftUI

struct ShowcaseTestimonialView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .testimonial)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGTestimonial(
                        quote: "…",
                        author: "Alex Rivera",
                        role: "Product Design Lead",
                        avatarInitials: "AR",
                        rating: 5
                    )
                    """) {
                        HIGTestimonial(
                            quote: "HIGDesign made our admin rebuild feel native on every Apple platform.",
                            author: "Alex Rivera",
                            role: "Product Design Lead",
                            avatarInitials: "AR",
                            rating: 5
                        )
                    }

                    ShowcaseSampleView(code: """
                    HIGTestimonial(
                        quote: "…",
                        author: "Sam Chen",
                        role: "Engineering Manager"
                    )
                    """) {
                        HIGTestimonial(
                            quote: "Token-first components keep our dashboards consistent without fighting the HIG.",
                            author: "Sam Chen",
                            role: "Engineering Manager"
                        )
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Testimonial")
    }
}

#if DEBUG
#Preview("ShowcaseTestimonialView") {
    ShowcasePreviewContainer {
        ShowcaseTestimonialView()
    }
}
#endif
