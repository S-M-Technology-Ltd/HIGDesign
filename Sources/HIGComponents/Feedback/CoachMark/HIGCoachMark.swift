import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed onboarding coach mark callout for multi-step product tours.
///
/// Shows step progress, title, message, and primary/secondary actions.
/// Inspired by Remark Admin intro tours; chrome resolves from ``HIGTheme/coachMark``.
/// Present over a host with ``View/higCoachMark(isPresented:title:message:stepIndex:stepCount:onNext:onSkip:onBack:)``.
public struct HIGCoachMark: View {
    private let title: String
    private let message: String
    private let stepIndex: Int
    private let stepCount: Int
    private let nextTitle: String
    private let skipTitle: String?
    private let backTitle: String?
    private let onNext: () -> Void
    private let onSkip: (() -> Void)?
    private let onBack: (() -> Void)?

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a coach mark card.
    /// - Parameters:
    ///   - title: Step title.
    ///   - message: Supporting guidance.
    ///   - stepIndex: 1-based step number.
    ///   - stepCount: Total steps in the tour.
    ///   - nextTitle: Primary action label (for example `"Next"` or `"Done"`).
    ///   - skipTitle: Optional skip action label.
    ///   - backTitle: Optional back action label.
    ///   - onNext: Primary action handler.
    ///   - onSkip: Optional skip handler.
    ///   - onBack: Optional back handler.
    public init(
        title: String,
        message: String,
        stepIndex: Int,
        stepCount: Int,
        nextTitle: String? = nil,
        skipTitle: String? = "Skip",
        backTitle: String? = nil,
        onNext: @escaping () -> Void,
        onSkip: (() -> Void)? = nil,
        onBack: (() -> Void)? = nil
    ) {
        let count = max(stepCount, 1)
        let index = min(max(stepIndex, 1), count)
        self.title = title
        self.message = message
        self.stepIndex = index
        self.stepCount = count
        self.nextTitle = nextTitle ?? (index >= count ? "Done" : "Next")
        self.skipTitle = skipTitle
        self.backTitle = backTitle ?? (index > 1 ? "Back" : nil)
        self.onNext = onNext
        self.onSkip = onSkip
        self.onBack = onBack
    }

    public var body: some View {
        let tokens = theme.coachMark
        let shape = RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)

        VStack(alignment: .leading, spacing: tokens.stackSpacing) {
            Text("Step \(stepIndex) of \(stepCount)")
                .font(tokens.stepFont)
                .foregroundStyle(theme.colors.labelSecondary)

            Text(title)
                .font(tokens.titleFont)
                .foregroundStyle(theme.colors.labelPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityAddTraits(.isHeader)

            Text(message)
                .font(tokens.messageFont)
                .foregroundStyle(theme.colors.labelSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: tokens.actionSpacing) {
                if let skipTitle, let onSkip {
                    HIGButton(skipTitle, role: .borderless, action: onSkip)
                }
                Spacer(minLength: 0)
                if let backTitle, let onBack {
                    HIGButton(backTitle, role: .secondary, action: onBack)
                }
                HIGButton(nextTitle, role: .primary, action: onNext)
            }
        }
        .padding(tokens.contentPadding)
        .frame(maxWidth: tokens.maxWidth, alignment: .leading)
        .background(theme.colors.backgroundSecondary)
        .clipShape(shape)
        .overlay {
            shape.strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Coach mark, step \(stepIndex) of \(stepCount). \(title). \(message)")
    }
}

extension View {
    /// Overlays a dimmed scrim and ``HIGCoachMark`` when `isPresented` is `true`.
    public func higCoachMark(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        stepIndex: Int,
        stepCount: Int,
        nextTitle: String? = nil,
        skipTitle: String? = "Skip",
        backTitle: String? = nil,
        onNext: @escaping () -> Void,
        onSkip: (() -> Void)? = nil,
        onBack: (() -> Void)? = nil
    ) -> some View {
        modifier(
            HIGCoachMarkOverlayModifier(
                isPresented: isPresented,
                title: title,
                message: message,
                stepIndex: stepIndex,
                stepCount: stepCount,
                nextTitle: nextTitle,
                skipTitle: skipTitle,
                backTitle: backTitle,
                onNext: onNext,
                onSkip: onSkip,
                onBack: onBack
            )
        )
    }
}

private struct HIGCoachMarkOverlayModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    let stepIndex: Int
    let stepCount: Int
    let nextTitle: String?
    let skipTitle: String?
    let backTitle: String?
    let onNext: () -> Void
    let onSkip: (() -> Void)?
    let onBack: (() -> Void)?

    @Environment(\.higTheme) private var theme

    func body(content: Content) -> some View {
        content.overlay {
            if isPresented {
                ZStack {
                    theme.colors.labelPrimary.opacity(theme.coachMark.scrimOpacity)
                        .ignoresSafeArea()
                        .accessibilityHidden(true)

                    VStack {
                        Spacer(minLength: 0)
                        HIGCoachMark(
                            title: title,
                            message: message,
                            stepIndex: stepIndex,
                            stepCount: stepCount,
                            nextTitle: nextTitle,
                            skipTitle: skipTitle,
                            backTitle: backTitle,
                            onNext: onNext,
                            onSkip: onSkip,
                            onBack: onBack
                        )
                        .padding(theme.spacing.screenEdge)
                        .padding(.bottom, theme.spacing.section)
                    }
                }
                .transition(.opacity)
            }
        }
    }
}

#if DEBUG
#Preview("HIGCoachMark") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGCoachMark(
            title: "Welcome to Admin",
            message: "Use the sidebar to jump between dashboards, reports, and settings.",
            stepIndex: 1,
            stepCount: 3,
            onNext: {},
            onSkip: {}
        )
        .padding()
    }
}
#endif
