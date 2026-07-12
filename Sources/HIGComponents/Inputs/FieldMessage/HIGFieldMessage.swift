import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// Helper or validation copy shown beneath a form field.
public struct HIGFieldMessage: View {
    private let text: String
    private let kind: HIGFieldMessageKind

    @Environment(\.higTheme) private var theme

    public init(_ text: String, kind: HIGFieldMessageKind = .helper) {
        self.text = text
        self.kind = kind
    }

    public var body: some View {
        let tokens = theme.fieldMessage

        HStack(alignment: .firstTextBaseline, spacing: tokens.spacing) {
            Image(systemName: kind.systemImage)
                .font(.system(size: tokens.iconPointSize, weight: .semibold))
                .foregroundStyle(foregroundColor)
                .accessibilityHidden(true)

            Text(text)
                .font(tokens.font)
                .foregroundStyle(foregroundColor)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabelText)
    }

    private var foregroundColor: Color {
        switch kind {
        case .helper:
            theme.colors.labelSecondary
        case .error:
            theme.colors.destructive
        case .success:
            theme.colors.success
        }
    }

    private var accessibilityLabelText: String {
        switch kind {
        case .helper:
            text
        case .error:
            "Error, \(text)"
        case .success:
            "Success, \(text)"
        }
    }
}

#if DEBUG
#Preview("HIGFieldMessage") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(alignment: .leading, spacing: HIGSpacing.md.rawValue) {
            HIGFieldMessage("Use your work email address.")
            HIGFieldMessage("Email is required.", kind: .error)
            HIGFieldMessage("Looks good.", kind: .success)
        }
        .padding()
    }
}
#endif
