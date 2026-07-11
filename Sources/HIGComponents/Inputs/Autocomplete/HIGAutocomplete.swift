import HIGPlatform
import HIGThemesContract
import SwiftUI

/// A text field that filters suggestions as the user types (typeahead).
///
/// Selecting a suggestion writes it into ``text``. Use ``HIGSelect`` when the
/// full option list should stay visible in a menu without free-form typing.
public struct HIGAutocomplete: View {
    private let label: String
    private let placeholder: String
    @Binding private var text: String
    private let suggestions: [String]
    private let maxVisibleSuggestions: Int

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @FocusState private var isFocused: Bool

    /// Creates an autocomplete field.
    /// - Parameters:
    ///   - label: Caption above the control.
    ///   - text: Bound query / committed value.
    ///   - suggestions: Full candidate list (filtered case-insensitively by `text`).
    ///   - placeholder: Empty-field placeholder.
    ///   - maxVisibleSuggestions: Cap on rows shown in the suggestion panel.
    public init(
        _ label: String,
        text: Binding<String>,
        suggestions: [String],
        placeholder: String = "Start typing…",
        maxVisibleSuggestions: Int = 8
    ) {
        self.label = label
        _text = text
        self.suggestions = suggestions
        self.placeholder = placeholder
        self.maxVisibleSuggestions = max(1, maxVisibleSuggestions)
    }

    public var body: some View {
        let tokens = theme.autocomplete
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)
        let filtered = filteredSuggestions

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(label)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)

            HStack(spacing: theme.spacing.compactItem) {
                TextField(placeholder, text: $text)
                    .font(tokens.font)
                    .textFieldStyle(.plain)
                    .focused($isFocused)
                    .foregroundStyle(theme.colors.labelPrimary)
                    .disabled(!isEnabled)

                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(theme.colors.labelSecondary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Clear \(label)")
                    .disabled(!isEnabled)
                }
            }
            .padding(.horizontal, tokens.horizontalPadding)
            .frame(minHeight: minHeight)
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

            if showsSuggestions, !filtered.isEmpty {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(filtered, id: \.self) { suggestion in
                            Button {
                                text = suggestion
                                isFocused = false
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
                            .disabled(!isEnabled)
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
    }

    private var showsSuggestions: Bool {
        isEnabled && isFocused && !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var filteredSuggestions: [String] {
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return [] }
        return suggestions
            .filter { $0.localizedCaseInsensitiveContains(query) && $0 != text }
            .prefix(maxVisibleSuggestions)
            .map { $0 }
    }
}

#if DEBUG
#Preview("HIGAutocomplete") {
    @Previewable @State var city = ""

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGAutocomplete(
            "City",
            text: $city,
            suggestions: ["Cupertino", "San Francisco", "Seattle", "Austin", "London", "Tokyo"]
        )
        .padding()
    }
}
#endif
