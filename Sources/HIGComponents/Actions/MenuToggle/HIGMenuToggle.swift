import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A menu affordance that toggles between hamburger lines and a close glyph.
///
/// Inspired by Remark Admin hamburger controls; use with side navigation or ``higDrawer``.
public struct HIGMenuToggle: View {
    @Binding private var isExpanded: Bool
    private let accessibilityCollapsedLabel: String
    private let accessibilityExpandedLabel: String

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// Creates a menu toggle.
    /// - Parameters:
    ///   - isExpanded: Binding for open/closed state.
    ///   - accessibilityCollapsedLabel: VoiceOver label when collapsed (default "Menu").
    ///   - accessibilityExpandedLabel: VoiceOver label when expanded (default "Close menu").
    public init(
        isExpanded: Binding<Bool>,
        accessibilityCollapsedLabel: String = "Menu",
        accessibilityExpandedLabel: String = "Close menu"
    ) {
        _isExpanded = isExpanded
        self.accessibilityCollapsedLabel = accessibilityCollapsedLabel
        self.accessibilityExpandedLabel = accessibilityExpandedLabel
    }

    public var body: some View {
        let tokens = theme.menuToggle

        Button {
            isExpanded.toggle()
        } label: {
            ZStack {
                menuLine(tokens: tokens)
                    .offset(y: isExpanded ? 0 : -tokens.lineSpacing)
                    .rotationEffect(.degrees(isExpanded ? 45 : 0))

                menuLine(tokens: tokens)
                    .opacity(isExpanded ? theme.opacity.hidden : theme.opacity.full)

                menuLine(tokens: tokens)
                    .offset(y: isExpanded ? 0 : tokens.lineSpacing)
                    .rotationEffect(.degrees(isExpanded ? -45 : 0))
            }
            .frame(width: tokens.minTapTarget, height: tokens.minTapTarget)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .animation(reduceMotion ? nil : .easeInOut(duration: theme.motion.quick), value: isExpanded)
        .accessibilityLabel(isExpanded ? accessibilityExpandedLabel : accessibilityCollapsedLabel)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(isExpanded ? "Expanded" : "Collapsed")
    }

    private func menuLine(tokens: any HIGMenuToggleTokens) -> some View {
        Capsule(style: .continuous)
            .fill(theme.colors.labelPrimary)
            .frame(width: tokens.lineWidth, height: tokens.lineThickness)
    }
}

#if DEBUG
#Preview("HIGMenuToggle") {
    struct HIGMenuTogglePreviewHostView: View {
        @State private var isExpanded = false

        var body: some View {
            HIGThemeableView(theme: HIGComponentPreviewTheme()) {
                HStack(spacing: 24) {
                    HIGMenuToggle(isExpanded: $isExpanded)
                    Text(isExpanded ? "Open" : "Closed")
                        .font(.body)
                }
                .padding()
            }
        }
    }

    return HIGMenuTogglePreviewHostView()
}
#endif
