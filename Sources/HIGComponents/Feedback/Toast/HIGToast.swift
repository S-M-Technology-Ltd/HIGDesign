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

    /// Presents queued toast messages from ``HIGToastQueue`` along the bottom edge.
    func higToastQueue(_ queue: HIGToastQueue) -> some View {
        modifier(HIGToastQueueModifier(queue: queue))
    }
}

private struct HIGToastQueueModifier: ViewModifier {
    @Bindable var queue: HIGToastQueue

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if let message = queue.currentMessage {
                    HIGToast(message)
                        .padding()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(reduceMotion ? nil : .easeInOut(duration: 0.2), value: queue.currentMessage)
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

private struct HIGToastQueuePreviewView: View {
    @State private var queue = HIGToastQueue()

    var body: some View {
        VStack(spacing: 16) {
            HIGButton("Queue Toasts", role: .primary) {
                queue.enqueue("Settings saved")
                queue.enqueue("Profile updated")
            }
        }
        .padding()
        .higToastQueue(queue)
    }
}

#Preview("HIGToastQueuePreviewView") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGToastQueuePreviewView()
    }
}
#endif