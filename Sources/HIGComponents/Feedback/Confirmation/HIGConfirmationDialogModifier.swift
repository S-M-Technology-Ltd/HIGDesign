import HIGThemesContract
import SwiftUI

public extension View {
    /// Presents a native confirmation dialog with HIG button roles.
    ///
    /// Prefer this for multi-option destructive or irreversible actions. Use
    /// ``higAlert(_:isPresented:message:primaryButtonTitle:primaryButtonRole:primaryAction:secondaryButtonTitle:secondaryButtonRole:secondaryAction:)``
    /// for classic alert presentations.
    func higConfirmationDialog(
        _ title: String,
        isPresented: Binding<Bool>,
        titleVisibility: Visibility = .visible,
        message: String? = nil,
        primaryButtonTitle: String,
        primaryButtonRole: HIGAlertButtonRole = .default,
        primaryAction: @escaping @MainActor () -> Void = {},
        secondaryButtonTitle: String? = "Cancel",
        secondaryButtonRole: HIGAlertButtonRole = .cancel,
        secondaryAction: @escaping @MainActor () -> Void = {}
    ) -> some View {
        modifier(
            HIGConfirmationDialogModifier(
                title: title,
                isPresented: isPresented,
                titleVisibility: titleVisibility,
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

private struct HIGConfirmationDialogModifier: ViewModifier {
    let title: String
    @Binding var isPresented: Bool
    let titleVisibility: Visibility
    let message: String?
    let primaryButtonTitle: String
    let primaryButtonRole: HIGAlertButtonRole
    let primaryAction: @MainActor () -> Void
    let secondaryButtonTitle: String?
    let secondaryButtonRole: HIGAlertButtonRole
    let secondaryAction: @MainActor () -> Void

    func body(content: Content) -> some View {
        content
            .confirmationDialog(title, isPresented: $isPresented, titleVisibility: titleVisibility) {
                Button(primaryButtonTitle, role: swiftUIRole(for: primaryButtonRole)) {
                    primaryAction()
                }
                if let secondaryButtonTitle {
                    Button(secondaryButtonTitle, role: swiftUIRole(for: secondaryButtonRole)) {
                        secondaryAction()
                    }
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
private struct HIGConfirmationDialogPreviewView: View {
    @State private var isPresented = false

    var body: some View {
        HIGThemeableView(theme: HIGComponentPreviewTheme()) {
            HIGButton("Delete item", role: .destructive) {
                isPresented = true
            }
            .higConfirmationDialog(
                "Delete this item?",
                isPresented: $isPresented,
                message: "This cannot be undone.",
                primaryButtonTitle: "Delete",
                primaryButtonRole: .destructive,
                secondaryButtonTitle: "Cancel",
                secondaryButtonRole: .cancel
            )
            .padding()
        }
    }
}

#Preview("higConfirmationDialog") {
    HIGConfirmationDialogPreviewView()
}
#endif
