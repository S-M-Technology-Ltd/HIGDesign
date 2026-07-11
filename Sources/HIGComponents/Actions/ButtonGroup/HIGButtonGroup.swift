import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A cluster of related action buttons with consistent spacing.
///
/// Inspired by Remark Admin button groups; prefer this for toolbar-style action rows
/// instead of ad-hoc `HStack` spacing. Children are typically ``HIGButton`` views.
public struct HIGButtonGroup<Content: View>: View {
    private let axis: HIGButtonGroupAxis
    private let equalWidth: Bool
    private let content: () -> Content

    @Environment(\.higTheme) private var theme

    /// Creates a button group.
    /// - Parameters:
    ///   - axis: Horizontal or vertical layout.
    ///   - equalWidth: When `true` on the horizontal axis, children share width equally.
    ///   - content: Button views to group.
    public init(
        axis: HIGButtonGroupAxis = .horizontal,
        equalWidth: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axis = axis
        self.equalWidth = equalWidth
        self.content = content
    }

    public var body: some View {
        let tokens = theme.buttonGroup

        Group {
            switch axis {
            case .horizontal:
                if equalWidth {
                    HIGEqualWidthHStackLayout(spacing: tokens.spacing) {
                        content()
                    }
                } else {
                    HStack(spacing: tokens.spacing) {
                        content()
                    }
                }
            case .vertical:
                VStack(spacing: tokens.spacing) {
                    content()
                }
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Button group")
    }
}

/// Horizontal layout that assigns equal width to each subview.
struct HIGEqualWidthHStackLayout: Layout {
    var spacing: CGFloat

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        guard !subviews.isEmpty else { return .zero }

        let count = CGFloat(subviews.count)
        let totalSpacing = spacing * max(count - 1, 0)
        let proposedWidth = proposal.width
        let childWidth: CGFloat
        if let proposedWidth, proposedWidth.isFinite {
            childWidth = max((proposedWidth - totalSpacing) / count, 0)
        } else {
            let maxIdeal = subviews.map { $0.sizeThatFits(.unspecified).width }.max() ?? 0
            childWidth = maxIdeal
        }

        let heights = subviews.map {
            $0.sizeThatFits(ProposedViewSize(width: childWidth, height: proposal.height)).height
        }
        let height = heights.max() ?? 0
        let width = childWidth * count + totalSpacing
        return CGSize(width: width, height: height)
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        guard !subviews.isEmpty else { return }

        let count = CGFloat(subviews.count)
        let totalSpacing = spacing * max(count - 1, 0)
        let childWidth = max((bounds.width - totalSpacing) / count, 0)
        var x = bounds.minX

        for subview in subviews {
            let size = subview.sizeThatFits(
                ProposedViewSize(width: childWidth, height: bounds.height)
            )
            let y = bounds.minY + (bounds.height - size.height) / 2
            subview.place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(width: childWidth, height: bounds.height)
            )
            x += childWidth + spacing
        }
    }
}

#if DEBUG
#Preview("HIGButtonGroup — Horizontal") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGButtonGroup {
            HIGButton("Cancel", role: .secondary) {}
            HIGButton("Save", role: .primary) {}
        }
        .padding()
    }
}

#Preview("HIGButtonGroup — Equal Width") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGButtonGroup(equalWidth: true) {
            HIGButton("Edit", role: .secondary) {}
            HIGButton("Share", role: .secondary) {}
            HIGButton("Delete", role: .destructive) {}
        }
        .padding()
    }
}

#Preview("HIGButtonGroup — Vertical") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGButtonGroup(axis: .vertical) {
            HIGButton("Continue", role: .primary) {}
            HIGButton("Not now", role: .borderless) {}
        }
        .padding()
    }
}
#endif
