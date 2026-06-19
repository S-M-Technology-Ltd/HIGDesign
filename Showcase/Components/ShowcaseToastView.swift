import HIGDesign
import SwiftUI

struct ShowcaseToastView: View {
    @State private var isPresented = false
    @State private var queue = HIGToastQueue()

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

                HIGButton("Queue Toasts", role: .secondary) {
                    queue.enqueue("Settings saved")
                    queue.enqueue("Profile updated")
                    queue.enqueue("Sync complete")
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Toast")
        .higToast(isPresented: $isPresented, message: "Settings saved")
        .higToastQueue(queue)
    }
}

#if DEBUG
#Preview("ShowcaseToastView") {
    ShowcaseToastView()
}
#endif