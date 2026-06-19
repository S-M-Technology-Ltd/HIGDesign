#if os(iOS)
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

extension View {
    func pickerHeaderCollapseSwipe(
        tokens: any HIGPhotoPickerTokens,
        onSwipe: @escaping (PickerHeaderSwipeDirection) -> Void
    ) -> some View {
        simultaneousGesture(
            DragGesture(minimumDistance: tokens.headerCollapseSwipeMinimumDistance)
                .onEnded { value in
                    let vertical = value.translation.height
                    guard abs(vertical) > abs(value.translation.width) else { return }

                    if vertical < -tokens.headerCollapseSwipeActivationDistance {
                        onSwipe(.up)
                    } else if vertical > tokens.headerCollapseSwipeActivationDistance {
                        onSwipe(.down)
                    }
                }
        )
    }
}
#endif