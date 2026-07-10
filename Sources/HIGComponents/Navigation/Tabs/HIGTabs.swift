import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// In-content tab labels with an underline selection indicator.
///
/// Distinct from ``HIGTabBar`` (app chrome) and ``HIGSegmentedControl`` (compact filters).
/// Pair with external content switched on `selection`.
public struct HIGTabs: View {
    @Binding private var selection: String
    private let items: [HIGTabsItem]

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public init(selection: Binding<String>, items: [HIGTabsItem]) {
        _selection = selection
        self.items = items
    }

    public var body: some View {
        let tokens = theme.tabs

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: tokens.itemSpacing) {
                ForEach(items) { item in
                    tabButton(item, tokens: tokens)
                }
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Tabs")
        .onAppear { ensureValidSelection() }
    }

    private func tabButton(_ item: HIGTabsItem, tokens: any HIGTabsTokens) -> some View {
        let isSelected = selection == item.id

        return Button {
            selection = item.id
        } label: {
            VStack(spacing: theme.spacing.compactItem) {
                Text(item.title)
                    .font(isSelected ? tokens.selectedFont : tokens.font)
                    .foregroundStyle(isSelected ? theme.colors.accent : theme.colors.labelSecondary)
                    .frame(minHeight: tokens.minTapTarget, alignment: .center)

                Rectangle()
                    .fill(theme.colors.accent.opacity(isSelected ? theme.opacity.full : theme.opacity.hidden))
                    .frame(height: tokens.underlineHeight)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .accessibilityLabel(item.title)
        .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : .isButton)
    }

    private func ensureValidSelection() {
        guard !items.isEmpty else { return }
        if !items.contains(where: { $0.id == selection }) {
            selection = items[0].id
        }
    }
}

#if DEBUG
#Preview("HIGTabs") {
    @Previewable @State var selection = "profile"

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(alignment: .leading, spacing: 16) {
            HIGTabs(
                selection: $selection,
                items: [
                    HIGTabsItem(id: "profile", title: "Profile"),
                    HIGTabsItem(id: "activity", title: "Activity"),
                    HIGTabsItem(id: "settings", title: "Settings"),
                ]
            )
            Text("Selected: \(selection)")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}
#endif
