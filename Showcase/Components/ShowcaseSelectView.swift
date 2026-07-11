import HIGDesign
import SwiftUI

private enum ShowcaseSelectRole: String, Hashable, Sendable {
    case admin
    case editor
    case viewer
}

private enum ShowcaseSelectTeam: String, Hashable, Sendable {
    case design
    case engineering
    case product
    case support
}

struct ShowcaseSelectView: View {
    @Environment(\.higTheme) private var theme
    @State private var role: ShowcaseSelectRole? = .editor
    @State private var teams: Set<ShowcaseSelectTeam> = [.design, .engineering]

    private let roleOptions: [HIGRadioOption<ShowcaseSelectRole>] = [
        HIGRadioOption(value: .admin, label: "Admin"),
        HIGRadioOption(value: .editor, label: "Editor"),
        HIGRadioOption(value: .viewer, label: "Viewer"),
    ]

    private let teamOptions: [HIGRadioOption<ShowcaseSelectTeam>] = [
        HIGRadioOption(value: .design, label: "Design"),
        HIGRadioOption(value: .engineering, label: "Engineering"),
        HIGRadioOption(value: .product, label: "Product"),
        HIGRadioOption(value: .support, label: "Support"),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .select)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGSelect("Role", selection: $role, options: roleOptions)
                    """) {
                        HIGSelect("Role", selection: $role, options: roleOptions)
                    }

                    ShowcaseSampleView(code: """
                    HIGSelect("Teams", selection: $teams, options: teamOptions)
                    """) {
                        HIGSelect("Teams", selection: $teams, options: teamOptions)
                    }

                    ShowcaseSampleView(code: """
                    HIGSelect("Disabled", selection: $role, options: roleOptions)
                        .disabled(true)
                    """) {
                        HIGSelect("Disabled", selection: $role, options: roleOptions)
                            .disabled(true)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Select")
    }
}

#if DEBUG
#Preview("ShowcaseSelectView") {
    ShowcasePreviewContainer {
        ShowcaseSelectView()
    }
}
#endif
