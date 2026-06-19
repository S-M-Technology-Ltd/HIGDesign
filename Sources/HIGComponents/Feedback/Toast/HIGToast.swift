import HIGThemesContract
import SwiftUI

/// A transient feedback banner aligned with HIG toast guidance.
public struct HIGToast: View {
    private let message: String

    @Environment(\.higTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(_ message: String) {
        self.message = message
    }

    public var body: some View {
        let tokens = theme.toast

        Text(message)
            .font(tokens.font)
            .foregroundStyle(theme.colors.labelPrimary)
            .padding(.horizontal, tokens.horizontalPadding)
            .padding(.vertical, tokens.verticalPadding)
            .background(theme.colors.backgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                    .strokeBorder(theme.colors.separator, lineWidth: 1)
            }
            .accessibilityLabel(message)
    }
}

public extension View {
    /// Shows a themed toast along the bottom edge when `isPresented` is true.
    func higToast(isPresented: Binding<Bool>, message: String) -> some View {
        modifier(HIGToastModifier(isPresented: isPresented, message: message))
    }
}

private struct HIGToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if isPresented {
                    HIGToast(message)
                        .padding()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(reduceMotion ? nil : .easeInOut(duration: 0.2), value: isPresented)
    }
}

#if DEBUG
#Preview("HIGToast") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGToast("Settings saved")
            .padding()
    }
}
#endif