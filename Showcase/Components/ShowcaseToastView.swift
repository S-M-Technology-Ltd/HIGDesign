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
                    ShowcaseSampleView(code: "HIGToast(\"Settings saved\", style: .success) { }") {
                        HIGToast("Settings saved", style: .success) {
                            // Showcase dismiss affordance
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGToast("Check connectivity", style: .warning)
                    HIGToast("Sync failed", style: .error)
                    """) {
                        VStack(spacing: theme.spacing.item) {
                            HIGToast("Check connectivity", style: .warning)
                            HIGToast("Sync failed", style: .error)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGButton("Show Toast", role: .primary) { isPresented = true }
                    .higToast(isPresented: $isPresented, message: "Settings saved", style: .success)
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
                    queue.enqueue("Settings saved", style: .success)
                    queue.enqueue("Profile updated", style: .info)
                    .higToastQueue(queue)
                    """) {
                        HIGButton("Queue Toasts", role: .secondary) {
                            queue.enqueue("Settings saved", style: .success)
                            queue.enqueue("Profile updated", style: .info)
                            queue.enqueue("Sync complete", style: .neutral)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Toast")
        .higToast(isPresented: $isPresented, message: "Settings saved", style: .success)
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