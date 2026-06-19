#if os(iOS)
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

private struct ContainerWidthPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

/// Reads container width once per meaningful layout change to avoid GeometryReader feedback loops.
struct ContainerWidthReaderView: View {
    @Binding var width: CGFloat
    @Environment(\.displayScale) private var displayScale
    @Environment(\.higTheme) private var theme

    private var layout: PickerLayout { PickerLayout(tokens: theme.photoPicker) }

    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(
                    key: ContainerWidthPreferenceKey.self,
                    value: layout.pixelAlignedLength(geometry.size.width, scale: displayScale)
                )
        }
    }
}

extension View {
    func onContainerWidthChange(_ width: Binding<CGFloat>) -> some View {
        background(ContainerWidthReaderView(width: width))
            .onPreferenceChange(ContainerWidthPreferenceKey.self) { newWidth in
                guard newWidth > 0 else { return }
                guard abs(newWidth - width.wrappedValue) > 0.5 else { return }
                width.wrappedValue = newWidth
            }
    }
}
#endif