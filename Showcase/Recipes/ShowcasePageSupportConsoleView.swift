import HIGDesign
import SwiftUI

/// Support console: ticket list, conversation thread, and agent actions.
struct ShowcasePageSupportConsoleView: View {
    @Environment(\.higTheme) private var theme
    @State private var selected = "t-8821"
    @State private var reply = ""
    @State private var priority: String? = "Normal"

    private let tickets: [(id: String, subject: String, customer: String, status: String)] = [
        ("t-8821", "Cannot export CSV", "Alex Kim", "Open"),
        ("t-8819", "Billing address wrong", "Jordan Lee", "Pending"),
        ("t-8814", "SSO login loop", "Sam Rivera", "Open"),
    ]

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageSupportConsole,
            code: """
            HIGListGroup tickets
            HIGChatBubble thread
            reply field + priority select + actions
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Support console",
                    subtitle: "Agent workspace for tickets, chat, and escalation."
                ) {
                    HIGBadge("3 open", style: .warning)
                }

                #if os(watchOS)
                ticketList
                conversation
                #else
                HStack(alignment: .top, spacing: theme.spacing.item) {
                    ticketList
                        .frame(maxWidth: 280)
                    conversation
                        .frame(maxWidth: .infinity)
                }
                #endif
            }
        }
    }

    private var ticketList: some View {
        HIGPanel("Tickets") {
            HIGListGroup {
                ForEach(Array(tickets.enumerated()), id: \.element.id) { index, ticket in
                    if index > 0 { HIGDivider() }
                    HIGListGroupRow(
                        ticket.subject,
                        subtitle: "\(ticket.id) · \(ticket.customer)",
                        systemImage: "ticket",
                        isSelected: selected == ticket.id
                    ) { selected = ticket.id }
                }
            }
        }
    }

    private var conversation: some View {
        let ticket = tickets.first(where: { $0.id == selected }) ?? tickets[0]
        return HIGPanel(ticket.subject, description: "\(ticket.id) · \(ticket.status)") {
            VStack(alignment: .leading, spacing: theme.spacing.item) {
                HStack(spacing: theme.spacing.item) {
                    HIGBadge(ticket.status, style: ticket.status == "Open" ? .accent : .neutral)
                    HIGSelect(
                        "Priority",
                        selection: $priority,
                        options: [
                            HIGRadioOption(value: "Low", label: "Low"),
                            HIGRadioOption(value: "Normal", label: "Normal"),
                            HIGRadioOption(value: "High", label: "High"),
                            HIGRadioOption(value: "Urgent", label: "Urgent"),
                        ]
                    )
                }

                VStack(spacing: theme.spacing.item) {
                    HIGChatBubble(
                        "Export keeps failing with a 403 after we rotated API keys.",
                        author: ticket.customer,
                        timestamp: "10:04 AM",
                        avatarInitials: String(ticket.customer.prefix(2)),
                        alignment: .leading
                    )
                    HIGChatBubble(
                        "Thanks — checking permissions on the export role now.",
                        author: "Support",
                        timestamp: "10:11 AM",
                        avatarInitials: "SU",
                        alignment: .trailing
                    )
                    HIGChatBubble(
                        "Can you confirm whether the workspace is on Admin plan?",
                        author: "Support",
                        timestamp: "10:12 AM",
                        avatarInitials: "SU",
                        alignment: .trailing
                    )
                }

                HIGTextEditor("Reply", text: $reply)
                HIGButtonGroup {
                    HIGButton("Internal note", role: .secondary) {}
                    HIGButton("Send reply", role: .primary) {}
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageSupportConsoleView") {
    ShowcasePreviewContainer { ShowcasePageSupportConsoleView() }
}
#endif
