import HIGComponents
import HIGThemesContract
import SwiftUI

extension View {
    /// Presents a themed slide drawer over the current content.
    public func higDrawer<DrawerContent: View>(
        isPresented: Binding<Bool>,
        edge: HIGDrawerEdge = .trailing,
        title: String? = nil,
        @ViewBuilder content: @escaping () -> DrawerContent
    ) -> some View {
        modifier(
            HIGDrawerModifier(
                isPresented: isPresented,
                edge: edge,
                title: title,
                drawerContent: content
            )
        )
    }
}

private struct HIGDrawerModifier<DrawerContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let edge: HIGDrawerEdge
    let title: String?
    let drawerContent: () -> DrawerContent

    @Environment(\.higTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content.overlay {
            ZStack(alignment: edgeAlignment) {
                if isPresented {
                    theme.colors.labelPrimary
                        .opacity(theme.drawer.scrimOpacity)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isPresented = false
                        }
                        .accessibilityLabel("Dismiss drawer")
                        .accessibilityAddTraits(.isButton)
                        .transition(.opacity)

                    HIGDrawer(
                        title: title,
                        onDismiss: { isPresented = false },
                        content: drawerContent
                    )
                    .padding(theme.spacing.screenEdge)
                    .transition(.move(edge: moveEdge))
                    .accessibilityAddTraits(.isModal)
                }
            }
            .animation(drawerAnimation, value: isPresented)
        }
    }

    private var edgeAlignment: Alignment {
        switch edge {
        case .leading: .leading
        case .trailing: .trailing
        }
    }

    private var moveEdge: Edge {
        switch edge {
        case .leading: .leading
        case .trailing: .trailing
        }
    }

    private var drawerAnimation: Animation? {
        reduceMotion ? nil : .easeInOut(duration: theme.motion.standard)
    }
}
