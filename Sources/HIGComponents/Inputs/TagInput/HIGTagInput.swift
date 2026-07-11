import HIGPlatform
import HIGThemesContract
import SwiftUI

/// A freeform tag field: type a value, commit it as a removable chip.
///
/// Use ``HIGSelect`` multi mode when tags must come from a fixed option list.
/// Use ``HIGAutocomplete`` for a single committed string with typeahead.
public struct HIGTagInput: View {
    private let label: String
    private let placeholder: String
    @Binding private var tags: [String]
    private let suggestions: [String]
    private let allowsDuplicates: Bool
    private let maxTags: Int?
    private let maxVisibleSuggestions: Int

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @State private var draft = ""
    @FocusState private var isFocused: Bool

    /// Creates a tag input field.
    /// - Parameters:
    ///   - label: Caption above the control.
    ///   - tags: Bound ordered list of committed tags.
    ///   - placeholder: Shown when there are no tags and the draft is empty.
    ///   - suggestions: Optional typeahead candidates filtered by the draft.
    ///   - allowsDuplicates: When `false` (default), case-insensitive duplicates are ignored.
    ///   - maxTags: Optional cap on committed tags; further commits are ignored.
    ///   - maxVisibleSuggestions: Cap on suggestion rows shown while typing.
    public init(
        _ label: String,
        tags: Binding<[String]>,
        placeholder: String = "Add tag…",
        suggestions: [String] = [],
        allowsDuplicates: Bool = false,
        maxTags: Int? = nil,
        maxVisibleSuggestions: Int = 8
    ) {
        self.label = label
        _tags = tags
        self.placeholder = placeholder
        self.suggestions = suggestions
        self.allowsDuplicates = allowsDuplicates
        self.maxTags = maxTags
        self.maxVisibleSuggestions = max(1, maxVisibleSuggestions)
    }

    public var body: some View {
        let tokens = theme.tagInput
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)
        let filtered = filteredSuggestions

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(label)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)

            VStack(alignment: .leading, spacing: tokens.chipSpacing) {
                HIGTagInputFlowWrap(spacing: tokens.chipSpacing) {
                    ForEach(Array(tags.enumerated()), id: \.offset) { index, tag in
                        HIGRemovableTag(tag) {
                            removeTag(at: index)
                        }
                    }

                    TextField(fieldPlaceholder, text: $draft)
                        .font(tokens.font)
                        .textFieldStyle(.plain)
                        .focused($isFocused)
                        .foregroundStyle(theme.colors.labelPrimary)
                        .disabled(!isEnabled || isAtMax)
                        .frame(minWidth: minFieldWidth)
                        .onSubmit(commitDraft)
                        #if os(iOS) || os(visionOS) || os(tvOS)
                        .textInputAutocapitalization(.never)
                        #endif
                        .autocorrectionDisabled()
                }

                if isEnabled, !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Button("Add") {
                        commitDraft()
                    }
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.accent)
                    .buttonStyle(.plain)
                    .disabled(isAtMax)
                    .accessibilityLabel("Add tag")
                }
            }
            .padding(.horizontal, tokens.horizontalPadding)
            .padding(.vertical, theme.spacing.compactItem)
            .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .leading)
            .background(theme.colors.backgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                    .strokeBorder(
                        isFocused ? theme.colors.accent : theme.colors.separator,
                        lineWidth: tokens.borderWidth
                    )
            }
            .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
            .contentShape(Rectangle())
            .onTapGesture {
                isFocused = true
            }

            if showsSuggestions, !filtered.isEmpty {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(filtered, id: \.self) { suggestion in
                            Button {
                                commit(suggestion)
                            } label: {
                                Text(suggestion)
                                    .font(tokens.font)
                                    .foregroundStyle(theme.colors.labelPrimary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, tokens.horizontalPadding)
                                    .frame(minHeight: max(tokens.suggestionRowMinHeight, capabilities.minimumTouchTarget))
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            .disabled(!isEnabled || isAtMax)
                        }
                    }
                }
                .frame(maxHeight: tokens.maxSuggestionHeight)
                .background(theme.colors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                        .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
                }
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(label)
        .accessibilityValue(tags.isEmpty ? placeholder : tags.joined(separator: ", "))
    }

    private var fieldPlaceholder: String {
        tags.isEmpty ? placeholder : ""
    }

    private var minFieldWidth: CGFloat {
        theme.spacing.section * 2
    }

    private var isAtMax: Bool {
        guard let maxTags else { return false }
        return tags.count >= maxTags
    }

    private var showsSuggestions: Bool {
        isEnabled && isFocused && !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var filteredSuggestions: [String] {
        let query = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return [] }
        return suggestions
            .filter { candidate in
                candidate.localizedCaseInsensitiveContains(query)
                    && !tags.contains(where: { $0.caseInsensitiveCompare(candidate) == .orderedSame })
            }
            .prefix(maxVisibleSuggestions)
            .map { $0 }
    }

    private func commitDraft() {
        commit(draft)
    }

    private func commit(_ raw: String) {
        let value = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !value.isEmpty else { return }
        guard !isAtMax else {
            draft = ""
            return
        }
        if !allowsDuplicates,
           tags.contains(where: { $0.caseInsensitiveCompare(value) == .orderedSame }) {
            draft = ""
            return
        }
        tags.append(value)
        draft = ""
    }

    private func removeTag(at index: Int) {
        guard tags.indices.contains(index) else { return }
        tags.remove(at: index)
    }
}

/// Wrapping layout for tag chips and the inline draft field.
private struct HIGTagInputFlowWrap<Content: View>: View {
    private let spacing: CGFloat
    private let content: () -> Content

    init(spacing: CGFloat, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        HIGTagInputFlowLayout(spacing: spacing) {
            content()
        }
    }
}

private struct HIGTagInputFlowLayout: Layout {
    var spacing: CGFloat

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var widthUsed: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x > 0, x + size.width > maxWidth {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
            widthUsed = max(widthUsed, x - spacing)
        }

        return CGSize(width: min(maxWidth, widthUsed), height: y + rowHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        var y = bounds.minY
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x > bounds.minX, x + size.width > bounds.maxX {
                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }
            subview.place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(width: size.width, height: size.height)
            )
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }
    }
}

#if DEBUG
#Preview("HIGTagInput") {
    @Previewable @State var tags = ["SwiftUI", "Design"]

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGTagInput(
            "Topics",
            tags: $tags,
            suggestions: ["SwiftUI", "Design", "Accessibility", "Tokens", "Admin"]
        )
        .padding()
    }
}
#endif
