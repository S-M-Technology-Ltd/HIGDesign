import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// One expandable section inside ``HIGAccordion``.
public struct HIGAccordionSection<Content: View>: View {
    private let id: String
    private let title: String
    @Binding private var expandedIDs: Set<String>
    private let allowsMultipleExpanded: Bool
    private let content: () -> Content

    @Environment(\.higTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(
        id: String,
        title: String,
        expandedIDs: Binding<Set<String>>,
        allowsMultipleExpanded: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.id = id
        self.title = title
        _expandedIDs = expandedIDs
        self.allowsMultipleExpanded = allowsMultipleExpanded
        self.content = content
    }

    public var body: some View {
        let tokens = theme.accordion
        let isExpanded = expandedIDs.contains(id)

        VStack(alignment: .leading, spacing: 0) {
            Button(action: toggle) {
                HStack(spacing: theme.spacing.item) {
                    Text(title)
                        .font(tokens.titleFont)
                        .foregroundStyle(theme.colors.labelPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: "chevron.down")
                        .font(.system(size: tokens.chevronPointSize, weight: .semibold))
                        .foregroundStyle(theme.colors.labelSecondary)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }
                .padding(tokens.contentPadding)
                .frame(minHeight: tokens.headerMinHeight)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(title)
            .accessibilityHint(isExpanded ? "Collapse section" : "Expand section")
            .accessibilityAddTraits(.isButton)
            .accessibilityValue(isExpanded ? "Expanded" : "Collapsed")

            if isExpanded {
                content()
                    .font(tokens.contentFont)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .bottom], tokens.contentPadding)
                    .transition(reduceMotion ? .opacity : .opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .animation(reduceMotion ? nil : .easeInOut(duration: theme.motion.standard), value: isExpanded)
        .accessibilityElement(children: .contain)
    }

    private func toggle() {
        if expandedIDs.contains(id) {
            expandedIDs.remove(id)
            return
        }
        if allowsMultipleExpanded {
            expandedIDs.insert(id)
        } else {
            expandedIDs = [id]
        }
    }
}

#if DEBUG
#Preview("HIGAccordionSection") {
    @Previewable @State var expanded: Set<String> = ["one"]

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGAccordionSection(
            id: "one",
            title: "Details",
            expandedIDs: $expanded
        ) {
            Text("Expanded body content.")
        }
        .padding()
    }
}
#endif
