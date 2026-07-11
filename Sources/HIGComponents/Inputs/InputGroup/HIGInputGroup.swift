import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A text-field chrome row with optional leading and trailing adornments.
///
/// Inspired by Bootstrap/Remark input groups. Place a bare `TextField` or other
/// control in the middle; the group supplies padding, background, and border.
public struct HIGInputGroup<Leading: View, Field: View, Trailing: View>: View {
    private let label: String?
    private let message: String?
    private let messageKind: HIGFieldMessageKind
    private let showsErrorBorder: Bool
    private let leading: () -> Leading
    private let field: () -> Field
    private let trailing: () -> Trailing

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public init(
        label: String? = nil,
        message: String? = nil,
        messageKind: HIGFieldMessageKind = .helper,
        showsErrorBorder: Bool = false,
        @ViewBuilder leading: @escaping () -> Leading,
        @ViewBuilder field: @escaping () -> Field,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.label = label
        self.message = message
        self.messageKind = messageKind
        self.showsErrorBorder = showsErrorBorder
        self.leading = leading
        self.field = field
        self.trailing = trailing
    }

    public var body: some View {
        let tokens = theme.inputGroup
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)
        let borderColor = showsErrorBorder || messageKind == .error
            ? theme.colors.destructive
            : theme.colors.separator

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            if let label {
                Text(label)
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)
            }

            HStack(spacing: tokens.adornmentSpacing) {
                leading()
                    .foregroundStyle(theme.colors.labelSecondary)

                field()
                    .font(tokens.font)
                    .foregroundStyle(theme.colors.labelPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                trailing()
                    .foregroundStyle(theme.colors.labelSecondary)
            }
            .padding(.horizontal, tokens.horizontalPadding)
            .frame(minHeight: minHeight)
            .background(theme.colors.backgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                    .strokeBorder(borderColor, lineWidth: tokens.borderWidth)
            }
            .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)

            if let message {
                HIGFieldMessage(message, kind: messageKind)
            }
        }
        .accessibilityElement(children: .contain)
    }
}

extension HIGInputGroup where Leading == EmptyView {
    /// Input group without a leading adornment.
    public init(
        label: String? = nil,
        message: String? = nil,
        messageKind: HIGFieldMessageKind = .helper,
        showsErrorBorder: Bool = false,
        @ViewBuilder field: @escaping () -> Field,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.init(
            label: label,
            message: message,
            messageKind: messageKind,
            showsErrorBorder: showsErrorBorder,
            leading: { EmptyView() },
            field: field,
            trailing: trailing
        )
    }
}

extension HIGInputGroup where Trailing == EmptyView {
    /// Input group without a trailing adornment.
    public init(
        label: String? = nil,
        message: String? = nil,
        messageKind: HIGFieldMessageKind = .helper,
        showsErrorBorder: Bool = false,
        @ViewBuilder leading: @escaping () -> Leading,
        @ViewBuilder field: @escaping () -> Field
    ) {
        self.init(
            label: label,
            message: message,
            messageKind: messageKind,
            showsErrorBorder: showsErrorBorder,
            leading: leading,
            field: field,
            trailing: { EmptyView() }
        )
    }
}

extension HIGInputGroup where Leading == EmptyView, Trailing == EmptyView {
    /// Input group with field chrome only (optional label and message).
    public init(
        label: String? = nil,
        message: String? = nil,
        messageKind: HIGFieldMessageKind = .helper,
        showsErrorBorder: Bool = false,
        @ViewBuilder field: @escaping () -> Field
    ) {
        self.init(
            label: label,
            message: message,
            messageKind: messageKind,
            showsErrorBorder: showsErrorBorder,
            leading: { EmptyView() },
            field: field,
            trailing: { EmptyView() }
        )
    }
}

#if DEBUG
#Preview("HIGInputGroup") {
    @Previewable @State var amount = "42"

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(alignment: .leading, spacing: HIGSpacing.lg.rawValue) {
            HIGInputGroup(label: "Amount") {
                Text("$")
                    .fontWeight(.semibold)
            } field: {
                TextField("0.00", text: $amount)
                    .textFieldStyle(.plain)
            } trailing: {
                Text("USD")
                    .font(.caption)
            }

            HIGInputGroup(
                label: "Email",
                message: "Enter a valid email address.",
                messageKind: .error,
                showsErrorBorder: true
            ) {
                Image(systemName: "envelope")
            } field: {
                TextField("name@example.com", text: .constant(""))
                    .textFieldStyle(.plain)
            }
        }
        .padding()
    }
}
#endif
