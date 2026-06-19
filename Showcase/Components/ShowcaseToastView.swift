import HIGDesign
import SwiftUI

struct ShowcaseToastView: View {
    @State private var isPresented = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .toast)

                HIGButton("Show Toast", role: .primary) {
                    isPresented = true
                    Task {
                        try? await Task.sleep(for: .seconds(2))
                        isPresented = false
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Toast")
        .higToast(isPresented: $isPresented, message: "Settings saved")
    }
}

#if DEBUG
#Preview("ShowcaseToastView") {
    ShowcaseToastView()
}
#endif