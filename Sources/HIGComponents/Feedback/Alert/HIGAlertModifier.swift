import HIGThemesContract
import SwiftUI

public extension View {
    /// Presents a native SwiftUI alert styled with HIG button roles.
    func higAlert(
        _ title: String,
        isPresented: Binding<Bool>,
        message: String? = nil,
        primaryButtonTitle: String,
        primaryButtonRole: HIGAlertButtonRole = .default,
        primaryAction: @escaping @MainActor () -> Void = {},
        secondaryButtonTitle: String? = nil,
        secondaryButtonRole: HIGAlertButtonRole = .cancel,
        secondaryAction: @escaping @MainActor () -> Void = {}
    ) -> some View {
        modifier(
            HIGAlertModifier(
                title: title,
                isPresented: isPresented,
                message: message,
                primaryButtonTitle: primaryButtonTitle,
                primaryButtonRole: primaryButtonRole,
                primaryAction: primaryAction,
                secondaryButtonTitle: secondaryButtonTitle,
                secondaryButtonRole: secondaryButtonRole,
                secondaryAction: secondaryAction
            )
        )
    }
}

private struct HIGAlertModifier: ViewModifier {
    let title: String
    @Binding var isPresented: Bool
    let message: String?
    let primaryButtonTitle: String
    let primaryButtonRole: HIGAlertButtonRole
    let primaryAction: @MainActor () -> Void
    let secondaryButtonTitle: String?
    let secondaryButtonRole: HIGAlertButtonRole
    let secondaryAction: @MainActor () -> Void

    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $isPresented) {
                if let secondaryButtonTitle {
                    Button(secondaryButtonTitle, role: swiftUIRole(for: secondaryButtonRole)) {
                        secondaryAction()
                    }
                }
                Button(primaryButtonTitle, role: swiftUIRole(for: primaryButtonRole)) {
                    primaryAction()
                }
            } message: {
                if let message {
                    Text(message)
                }
            }
    }

    private func swiftUIRole(for role: HIGAlertButtonRole) -> ButtonRole? {
        switch role {
        case .default:
            nil
        case .destructive:
            .destructive
        case .cancel:
            .cancel
        }
    }
}

#if DEBUG
private struct HIGAlertPreviewView: View {
    @State private var isPresented = false

    var body: some View {
        HIGButton("Show Alert", role: .primary) {
            isPresented = true
        }
        .higAlert(
            "Delete Item?",
            isPresented: $isPresented,
            message: "This action cannot be undone.",
            primaryButtonTitle: "Delete",
            primaryButtonRole: .destructive,
            secondaryButtonTitle: "Cancel",
            secondaryButtonRole: .cancel
        )
        .padding()
    }
}

#Preview("HIGAlertPreviewView") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGAlertPreviewView()
    }
}
#endif