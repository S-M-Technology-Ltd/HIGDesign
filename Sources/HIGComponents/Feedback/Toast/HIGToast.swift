import HIGThemesContract
import HIGTokensRaw
import SwiftUI

/// A transient feedback banner aligned with HIG toast guidance.
public struct HIGToast: View {
    private let message: String
    private let style: HIGToastStyle
    private let onDismiss: (() -> Void)?

    @Environment(\.higTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(
        _ message: String,
        style: HIGToastStyle = .neutral,
        onDismiss: (() -> Void)? = nil
    ) {
        self.message = message
        self.style = style
        self.onDismiss = onDismiss
    }

    public var body: some View {
        let tokens = theme.toast

        HStack(spacing: theme.spacing.compactItem) {
            Image(systemName: style.systemImage)
                .font(tokens.font.weight(.semibold))
                .foregroundStyle(style.accentColor(theme: theme))
                .accessibilityHidden(true)

            Text(message)
                .font(tokens.font)
                .foregroundStyle(theme.colors.labelPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let onDismiss {
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(theme.colors.labelSecondary)
                        .frame(width: tokens.dismissButtonSize, height: tokens.dismissButtonSize)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Dismiss")
            }
        }
        .padding(.horizontal, tokens.horizontalPadding)
        .padding(.vertical, tokens.verticalPadding)
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(
                    style.accentColor(theme: theme).opacity(theme.opacity.bannerBorder),
                    lineWidth: theme.border.hairline
                )
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(message)
        .accessibilityValue(style.rawValue)
    }
}

public extension View {
    /// Shows a themed toast along the bottom edge when `isPresented` is true.
    func higToast(
        isPresented: Binding<Bool>,
        message: String,
        style: HIGToastStyle = .neutral
    ) -> some View {
        modifier(HIGToastModifier(isPresented: isPresented, message: message, style: style))
    }

    /// Presents queued toast messages from ``HIGToastQueue`` along the bottom edge.
    func higToastQueue(_ queue: HIGToastQueue) -> some View {
        modifier(HIGToastQueueModifier(queue: queue))
    }
}

private struct HIGToastQueueModifier: ViewModifier {
    @Bindable var queue: HIGToastQueue

    @Environment(\.higTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if let item = queue.current {
                    HIGToast(
                        item.message,
                        style: item.style,
                        onDismiss: queue.configuration.allowsManualDismissal ? {
                            queue.dismissCurrent()
                        } : nil
                    )
                    .padding()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(reduceMotion ? nil : .easeInOut(duration: theme.motion.quick), value: queue.current)
    }
}

private struct HIGToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let style: HIGToastStyle

    @Environment(\.higTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if isPresented {
                    HIGToast(message, style: style) {
                        isPresented = false
                    }
                    .padding()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(reduceMotion ? nil : .easeInOut(duration: theme.motion.quick), value: isPresented)
    }
}

#if DEBUG
#Preview("HIGToast") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: HIGSpacing.md.rawValue) {
            HIGToast("Settings saved", style: .success) {}
            HIGToast("Check your network", style: .warning) {}
            HIGToast("Sync failed", style: .error) {}
        }
        .padding()
    }
}

private struct HIGToastQueuePreviewView: View {
    @State private var queue = HIGToastQueue(configuration: .interactive)

    var body: some View {
        VStack(spacing: HIGSpacing.lg.rawValue) {
            HIGButton("Queue Toasts", role: .primary) {
                queue.enqueue("Settings saved", style: .success)
                queue.enqueue("Profile updated", style: .info)
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
