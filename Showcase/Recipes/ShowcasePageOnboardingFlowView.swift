import HIGDesign
import SwiftUI

/// Multi-step product onboarding wizard with validation messaging.
struct ShowcasePageOnboardingFlowView: View {
    @Environment(\.higTheme) private var theme
    @State private var step = 0
    @State private var company = ""
    @State private var role: String? = "Product"
    @State private var goals = ""
    @State private var invites = ""

    private let steps = [
        HIGStepsItem(id: "org", title: "Organization", detail: "Basics"),
        HIGStepsItem(id: "goals", title: "Goals", detail: "Use cases"),
        HIGStepsItem(id: "invite", title: "Invite", detail: "Team"),
        HIGStepsItem(id: "done", title: "Finish", detail: "Launch"),
    ]

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageOnboardingFlow,
            code: """
            HIGPageHeader("Welcome")
            HIGSteps(currentIndex:)
            step body forms + HIGPearlSteps
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Welcome to HIG Admin",
                    subtitle: "A guided setup flow for new workspaces."
                )

                HIGSteps(items: steps, currentIndex: step, onSelect: { step = min(max($0, 0), steps.count - 1) })
                HIGPearlSteps(count: steps.count, currentIndex: step)

                HIGPanel(steps[step].title, description: steps[step].detail) {
                    stepBody
                }

                HIGButtonGroup {
                    HIGButton("Back", role: .secondary) {
                        step = max(step - 1, 0)
                    }
                    HIGButton(step >= steps.count - 1 ? "Launch workspace" : "Continue", role: .primary) {
                        step = min(step + 1, steps.count - 1)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var stepBody: some View {
        switch step {
        case 0:
            VStack(alignment: .leading, spacing: theme.spacing.item) {
                HIGTextField("Company name", text: $company, placeholder: "Acme Inc.")
                HIGSelect(
                    "Your role",
                    selection: $role,
                    options: [
                        HIGRadioOption(value: "Product", label: "Product"),
                        HIGRadioOption(value: "Engineering", label: "Engineering"),
                        HIGRadioOption(value: "Design", label: "Design"),
                        HIGRadioOption(value: "Ops", label: "Ops"),
                        HIGRadioOption(value: "Other", label: "Other"),
                    ]
                )
                HIGFieldMessage(company.isEmpty ? "Company name is required." : "Looks good.", kind: company.isEmpty ? .error : .success)
            }
        case 1:
            VStack(alignment: .leading, spacing: theme.spacing.item) {
                HIGTextEditor("What are you trying to ship?", text: $goals)
                HIGTagInput(
                    "Focus areas",
                    tags: .constant(["Dashboards", "Support", "Billing"]),
                    suggestions: ["Analytics", "Auth", "CMS"]
                )
            }
        case 2:
            VStack(alignment: .leading, spacing: theme.spacing.item) {
                HIGTextField("Invite emails", text: $invites, placeholder: "teammate@example.com")
                HIGFieldMessage("Separate multiple emails with commas.", kind: .helper)
                HIGEmptyState(
                    "No teammates yet",
                    message: "You can skip invites and add people later from Team settings.",
                    systemImage: "person.2"
                )
            }
        default:
            VStack(alignment: .leading, spacing: theme.spacing.item) {
                HIGEmptyState(
                    "You're ready",
                    message: "Open the operations dashboard to start composing admin surfaces.",
                    systemImage: "checkmark.seal"
                ) {
                    HIGButton("Go to dashboard", role: .primary) {}
                }
                HIGProgressView("Setup complete", value: 1, showsPercentage: true)
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageOnboardingFlowView") {
    ShowcasePreviewContainer { ShowcasePageOnboardingFlowView() }
}
#endif
