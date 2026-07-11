import HIGPlatform
import HIGThemesContract
import SwiftUI

/// A form select with field chrome for single or multi selection from a fixed list.
///
/// Prefer ``HIGPicker`` for compact menu pickers without bordered chrome.
/// Use ``HIGAutocomplete`` when options should filter as the user types.
public struct HIGSelect<Value: Hashable & Sendable>: View {
    private enum Mode {
        case single(Binding<Value?>)
        case multi(Binding<Set<Value>>)
    }

    private let label: String
    private let placeholder: String
    private let options: [HIGRadioOption<Value>]
    private let mode: Mode

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a single-value select (optional selection shows the placeholder).
    public init(
        _ label: String,
        selection: Binding<Value?>,
        options: [HIGRadioOption<Value>],
        placeholder: String = "Select…"
    ) {
        self.label = label
        self.placeholder = placeholder
        self.options = options
        self.mode = .single(selection)
    }

    /// Creates a multi-value select. Selected values appear as removable tags.
    public init(
        _ label: String,
        selection: Binding<Set<Value>>,
        options: [HIGRadioOption<Value>],
        placeholder: String = "Select…"
    ) {
        self.label = label
        self.placeholder = placeholder
        self.options = options
        self.mode = .multi(selection)
    }

    public var body: some View {
        let tokens = theme.select
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(label)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)

            HStack(alignment: .center, spacing: theme.spacing.compactItem) {
                content
                    .frame(maxWidth: .infinity, alignment: .leading)

                Image(systemName: "chevron.up.chevron.down")
                    .font(.system(size: tokens.chevronPointSize, weight: .semibold))
                    .foregroundStyle(theme.colors.labelSecondary)
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, tokens.horizontalPadding)
            .padding(.vertical, theme.spacing.compactItem)
            .frame(minHeight: minHeight, alignment: .leading)
            .background(theme.colors.backgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                    .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
            }
            .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
            .font(tokens.font)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityValue(accessibilityValue)
    }

    @ViewBuilder
    private var content: some View {
        switch mode {
        case .single(let selection):
            singleMenu(selection: selection)
        case .multi(let selection):
            multiContent(selection: selection)
        }
    }

    private func singleMenu(selection: Binding<Value?>) -> some View {
        Menu {
            Button("Clear") {
                selection.wrappedValue = nil
            }
            .disabled(selection.wrappedValue == nil)

            Divider()

            ForEach(options) { option in
                Button {
                    selection.wrappedValue = option.value
                } label: {
                    if selection.wrappedValue == option.value {
                        Label(option.label, systemImage: "checkmark")
                    } else {
                        Text(option.label)
                    }
                }
            }
        } label: {
            Text(singleDisplayLabel(selection.wrappedValue))
                .foregroundStyle(
                    selection.wrappedValue == nil
                        ? theme.colors.labelSecondary
                        : theme.colors.labelPrimary
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
        }
        .menuStyle(.button)
        .buttonStyle(.plain)
        .disabled(!isEnabled)
    }

    @ViewBuilder
    private func multiContent(selection: Binding<Set<Value>>) -> some View {
        let selected = selection.wrappedValue
        let selectedOptions = options.filter { selected.contains($0.value) }
        let available = options.filter { !selected.contains($0.value) }

        HStack(alignment: .center, spacing: theme.select.chipSpacing) {
            if selectedOptions.isEmpty {
                Text(placeholder)
                    .foregroundStyle(theme.colors.labelSecondary)
            } else {
                FlowWrap(spacing: theme.select.chipSpacing) {
                    ForEach(selectedOptions) { option in
                        HIGRemovableTag(option.label) {
                            var next = selection.wrappedValue
                            next.remove(option.value)
                            selection.wrappedValue = next
                        }
                    }
                }
            }

            Spacer(minLength: 0)

            Menu {
                if available.isEmpty {
                    Text("All options selected")
                } else {
                    ForEach(available) { option in
                        Button(option.label) {
                            var next = selection.wrappedValue
                            next.insert(option.value)
                            selection.wrappedValue = next
                        }
                    }
                }
            } label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(theme.colors.accent)
                    .accessibilityLabel("Add \(label)")
            }
            .menuStyle(.button)
            .buttonStyle(.plain)
            .disabled(!isEnabled || available.isEmpty)
        }
    }

    private func singleDisplayLabel(_ value: Value?) -> String {
        guard let value else { return placeholder }
        return options.first(where: { $0.value == value })?.label ?? placeholder
    }

    private var accessibilityValue: String {
        switch mode {
        case .single(let selection):
            return singleDisplayLabel(selection.wrappedValue)
        case .multi(let selection):
            let labels = options
                .filter { selection.wrappedValue.contains($0.value) }
                .map(\.label)
            return labels.isEmpty ? placeholder : labels.joined(separator: ", ")
        }
    }
}

/// Simple wrapping layout for multi-select chips without third-party deps.
private struct FlowWrap<Content: View>: View {
    private let spacing: CGFloat
    private let content: () -> Content

    init(spacing: CGFloat, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        // Prefer a horizontal stack that wraps via flexible width in form contexts.
        // Uses ViewThatFits-friendly wrapping via LazyVGrid-like behavior without fixed columns.
        _FlowWrapLayout(spacing: spacing) {
            content()
        }
    }
}

private struct _FlowWrapLayout: Layout {
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
private enum HIGSelectPreviewRole: String, Hashable, Sendable {
    case admin
    case editor
    case viewer
}

#Preview("HIGSelect") {
    @Previewable @State var role: HIGSelectPreviewRole? = .editor
    @Previewable @State var teams: Set<HIGSelectPreviewRole> = [.admin]

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(alignment: .leading, spacing: 16) {
            HIGSelect(
                "Role",
                selection: $role,
                options: [
                    HIGRadioOption(value: .admin, label: "Admin"),
                    HIGRadioOption(value: .editor, label: "Editor"),
                    HIGRadioOption(value: .viewer, label: "Viewer"),
                ]
            )
            HIGSelect(
                "Teams",
                selection: $teams,
                options: [
                    HIGRadioOption(value: .admin, label: "Admin"),
                    HIGRadioOption(value: .editor, label: "Editor"),
                    HIGRadioOption(value: .viewer, label: "Viewer"),
                ]
            )
        }
        .padding()
    }
}
#endif
