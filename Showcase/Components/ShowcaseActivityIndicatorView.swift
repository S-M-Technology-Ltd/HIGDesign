import HIGDesign
import SwiftUI

struct ShowcaseActivityIndicatorView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .activityIndicator)

                VStack(alignment: .leading, spacing: 12) {
                    Text("System")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    VStack(alignment: .leading, spacing: 20) {
                        HIGActivityIndicator("Syncing library", size: .small, style: .system)
                        HIGActivityIndicator("Syncing library", size: .medium, style: .system)
                        HIGActivityIndicator("Syncing library", size: .large, style: .system)
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Custom styles")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    VStack(alignment: .leading, spacing: 20) {
                        HIGActivityIndicator("Orbital", size: .medium, style: .orbital)
                        HIGActivityIndicator("Pulsing", size: .medium, style: .pulsing)
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Shimmer placeholder")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    shimmerPlaceholder
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Activity Indicator")
    }

    private var shimmerPlaceholder: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Loading profile")
                .font(.headline)
            Text("Fetching account details and preferences.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .redacted(reason: .placeholder)
        .higShimmer()
    }
}

#if DEBUG
#Preview("ShowcaseActivityIndicatorView") {
    ShowcaseActivityIndicatorView()
}
#endif