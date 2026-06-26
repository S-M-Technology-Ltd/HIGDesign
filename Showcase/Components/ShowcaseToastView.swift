import HIGDesign
import SwiftUI

struct ShowcaseToastView: View {
    @Environment(\.higTheme) private var theme
    @State private var isPresented = false
    @State private var queue = HIGToastQueue(configuration: .interactive)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .toast)

                VStack(spacing: theme.spacing.item) {
                    ShowcaseSampleView(code: "HIGToast(\"Settings saved\") { }") {
                        HIGToast("Settings saved") {
                            // Showcase dismiss affordance
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGButton("Show Toast", role: .primary) { isPresented = true }
                    .higToast(isPresented: $isPresented, message: "Settings saved")
                    """) {
                        HIGButton("Show Toast", role: .primary) {
                            isPresented = true
                            Task {
                                try? await Task.sleep(for: .seconds(2))
                                isPresented = false
                            }
                        }
                    }

                    ShowcaseSampleView(code: """
                    @State private var queue = HIGToastQueue(configuration: .interactive)
                    // ...
                    HIGButton("Queue Toasts", role: .secondary) {
                        queue.enqueue("Settings saved")
                        queue.enqueue("Profile updated")
                        queue.enqueue("Sync complete")
                    }
                    .higToastQueue(queue)
                    """) {
                        HIGButton("Queue Toasts", role: .secondary) {
                            queue.enqueue("Settings saved")
                            queue.enqueue("Profile updated")
                            queue.enqueue("Sync complete")
                        }
                    }
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
    ShowcasePreviewContainer {
        ShowcaseToastView()
    }
}
#endif