import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// Page-level title chrome with optional breadcrumb trail, subtitle, and trailing actions.
///
/// Inspired by Remark Admin page headers; uses HIG typography and ``HIGBreadcrumb``.
public struct HIGPageHeader<Trailing: View>: View {
    private let title: String
    private let subtitle: String?
    private let breadcrumbItems: [HIGBreadcrumbItem]
    private let onBreadcrumbSelect: ((HIGBreadcrumbItem) -> Void)?
    private let trailing: () -> Trailing

    @Environment(\.higTheme) private var theme

    public init(
        _ title: String,
        subtitle: String? = nil,
        breadcrumbItems: [HIGBreadcrumbItem] = [],
        onBreadcrumbSelect: ((HIGBreadcrumbItem) -> Void)? = nil,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.title = title
        self.subtitle = subtitle
        self.breadcrumbItems = breadcrumbItems
        self.onBreadcrumbSelect = onBreadcrumbSelect
        self.trailing = trailing
    }

    public var body: some View {
        let tokens = theme.pageHeader

        VStack(alignment: .leading, spacing: tokens.breadcrumbSpacing) {
            if !breadcrumbItems.isEmpty {
                HIGBreadcrumb(items: breadcrumbItems, onSelect: onBreadcrumbSelect)
            }

            HStack(alignment: .firstTextBaseline, spacing: theme.spacing.item) {
                VStack(alignment: .leading, spacing: tokens.stackSpacing) {
                    Text(title)
                        .font(tokens.titleFont)
                        .foregroundStyle(theme.colors.labelPrimary)
                        .accessibilityAddTraits(.isHeader)

                    if let subtitle {
                        Text(subtitle)
                            .font(tokens.subtitleFont)
                            .foregroundStyle(theme.colors.labelSecondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                trailing()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabelText)
    }

    private var accessibilityLabelText: String {
        if let subtitle {
            "\(title). \(subtitle)"
        } else {
            title
        }
    }
}

extension HIGPageHeader where Trailing == EmptyView {
    /// Creates a page header without trailing actions.
    public init(
        _ title: String,
        subtitle: String? = nil,
        breadcrumbItems: [HIGBreadcrumbItem] = [],
        onBreadcrumbSelect: ((HIGBreadcrumbItem) -> Void)? = nil
    ) {
        self.init(
            title,
            subtitle: subtitle,
            breadcrumbItems: breadcrumbItems,
            onBreadcrumbSelect: onBreadcrumbSelect,
            trailing: { EmptyView() }
        )
    }
}

#if DEBUG
#Preview("HIGPageHeader") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGPageHeader(
            "Buttons",
            subtitle: "Primary and secondary actions",
            breadcrumbItems: [
                HIGBreadcrumbItem("Home"),
                HIGBreadcrumbItem("UI Kit"),
                HIGBreadcrumbItem("Buttons"),
            ],
            onBreadcrumbSelect: { _ in }
        ) {
            HIGButton("New", role: .primary) {}
        }
        .padding()
    }
}

#Preview("HIGPageHeader — Title Only") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGPageHeader("Dashboard")
            .padding()
    }
}
#endif
