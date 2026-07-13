import HIGDesign
import SwiftUI

/// Workspace settings hub: identity, security, notifications, danger zone.
struct ShowcasePageWorkspaceSettingsView: View {
    @Environment(\.higTheme) private var theme
    @State private var workspace = "HIG Admin"
    @State private var domain = "admin.example.com"
    @State private var timezone: String? = "America/Los_Angeles"
    @State private var twoFactor = true
    @State private var emailDigest = true
    @State private var slackAlerts = false
    @State private var tab = "general"

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageWorkspaceSettings,
            code: """
            HIGPageHeader("Settings")
            HIGTabs(general / security / notifications)
            HIGFormSection + toggles + field messages
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Workspace settings",
                    subtitle: "Configure identity, security, and notification channels."
                ) {
                    HIGButton("Save", role: .primary) {}
                }

                HIGTabs(
                    selection: $tab,
                    items: [
                        HIGTabsItem(id: "general", title: "General"),
                        HIGTabsItem(id: "security", title: "Security"),
                        HIGTabsItem(id: "notifications", title: "Notifications"),
                    ]
                )

                switch tab {
                case "security":
                    securitySection
                case "notifications":
                    notificationsSection
                default:
                    generalSection
                }

                HIGPanel("Danger zone", description: "Irreversible workspace actions") {
                    VStack(alignment: .leading, spacing: theme.spacing.item) {
                        Text("Transfer ownership or delete this workspace.")
                            .font(theme.typography.body)
                            .foregroundStyle(theme.colors.labelSecondary)
                        HIGButton("Delete workspace", role: .destructive) {}
                    }
                }
            }
        }
    }

    private var generalSection: some View {
        HIGPanel("General", description: "Public workspace identity") {
            VStack(alignment: .leading, spacing: theme.spacing.item) {
                HIGTextField("Workspace name", text: $workspace)
                HIGTextField("Primary domain", text: $domain, placeholder: "app.example.com")
                HIGFieldMessage("Custom domains require a verified DNS CNAME.", kind: .helper)
                HIGSelect(
                    "Timezone",
                    selection: $timezone,
                    options: [
                        HIGRadioOption(value: "America/Los_Angeles", label: "America/Los_Angeles"),
                        HIGRadioOption(value: "America/New_York", label: "America/New_York"),
                        HIGRadioOption(value: "Europe/London", label: "Europe/London"),
                        HIGRadioOption(value: "Asia/Tokyo", label: "Asia/Tokyo"),
                    ]
                )
            }
        }
    }

    private var securitySection: some View {
        HIGPanel("Security", description: "Authentication policy") {
            VStack(alignment: .leading, spacing: theme.spacing.item) {
                HIGToggle("Require two-factor authentication", isOn: $twoFactor)
                HIGFieldMessage(
                    twoFactor ? "Members must enroll an authenticator app." : "2FA is optional for members.",
                    kind: twoFactor ? .success : .helper
                )
                HIGListGroup(header: "Sessions") {
                    HIGListGroupRow("MacBook Pro · Safari", subtitle: "Cupertino · Active now", systemImage: "laptopcomputer") {}
                    HIGDivider()
                    HIGListGroupRow("iPhone · App", subtitle: "Last seen 2h ago", systemImage: "iphone", showsChevron: true) {}
                }
            }
        }
    }

    private var notificationsSection: some View {
        HIGPanel("Notifications", description: "How the team hears about incidents") {
            VStack(alignment: .leading, spacing: theme.spacing.item) {
                HIGToggle("Weekly email digest", isOn: $emailDigest)
                HIGToggle("Slack incident alerts", isOn: $slackAlerts)
                if slackAlerts {
                    HIGFieldMessage("Connect Slack under Integrations to route Sev-1 pages.", kind: .helper)
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageWorkspaceSettingsView") {
    ShowcasePreviewContainer { ShowcasePageWorkspaceSettingsView() }
}
#endif
