import HIGDesign
import SwiftUI

struct ShowcaseToastView: View {
    @State private var isPresented = false
    @State private var queue = HIGToastQueue(configuration: .interactive)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .toast)

                HIGToast("Settings saved") {
                    // Showcase dismiss affordance
                }

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