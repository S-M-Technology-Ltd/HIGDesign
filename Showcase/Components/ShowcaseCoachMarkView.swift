import HIGDesign
import SwiftUI

struct ShowcaseCoachMarkView: View {
    @Environment(\.higTheme) private var theme
    @State private var step = 1
    @State private var isTourPresented = false

    private let steps: [(title: String, message: String)] = [
        (
            "Welcome to Admin",
            "Use the sidebar to move between dashboards, reports, and settings."
        ),
        (
            "Switch themes",
            "Try Admin, High Contrast, or Brand themes from the showcase settings."
        ),
        (
            "You’re ready",
            "Explore components in the catalog and compose recipes for your app."
        )
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .coachMark)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGCoachMark(
                        title: "…",
                        message: "…",
                        stepIndex: 1,
                        stepCount: 3,
                        onNext: { /* … */ },
                        onSkip: { /* … */ }
                    )
                    """) {
                        HIGCoachMark(
                            title: steps[0].title,
                            message: steps[0].message,
                            stepIndex: 1,
                            stepCount: steps.count,
                            onNext: {},
                            onSkip: {}
                        )
                    }

                    ShowcaseSampleView(code: """
                    content.higCoachMark(
                        isPresented: $showTour,
                        title: "…",
                        message: "…",
                        stepIndex: step,
                        stepCount: 3,
                        onNext: { /* advance */ },
                        onSkip: { showTour = false }
                    )
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGButton("Start tour", role: .primary) {
                                step = 1
                                isTourPresented = true
                            }
                            Text("Current step: \(step)")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                        .frame(maxWidth: .infinity, minHeight: 180, alignment: .topLeading)
                        .higCoachMark(
                            isPresented: $isTourPresented,
                            title: steps[safe: step - 1]?.title ?? steps[0].title,
                            message: steps[safe: step - 1]?.message ?? steps[0].message,
                            stepIndex: step,
                            stepCount: steps.count,
                            onNext: {
                                if step >= steps.count {
                                    isTourPresented = false
                                } else {
                                    step += 1
                                }
                            },
                            onSkip: {
                                isTourPresented = false
                            },
                            onBack: step > 1 ? { step -= 1 } : nil
                        )
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Coach Mark")
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

#if DEBUG
#Preview("ShowcaseCoachMarkView") {
    ShowcasePreviewContainer {
        ShowcaseCoachMarkView()
    }
}
#endif
