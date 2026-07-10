import HIGThemesContract
import SwiftUI

/// Vertical stack of accordion sections with theme-backed spacing.
public struct HIGAccordion<Content: View>: View {
    private let content: () -> Content

    @Environment(\.higTheme) private var theme

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.accordion.sectionSpacing) {
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .contain)
    }
}

#if DEBUG
#Preview("HIGAccordion") {
    @Previewable @State var expanded: Set<String> = ["billing"]

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGAccordion {
            HIGAccordionSection(
                id: "profile",
                title: "Profile",
                expandedIDs: $expanded
            ) {
                Text("Name, email, and avatar settings.")
            }
            HIGAccordionSection(
                id: "billing",
                title: "Billing",
                expandedIDs: $expanded
            ) {
                Text("Invoices and payment methods.")
            }
        }
        .padding()
    }
}
#endif
