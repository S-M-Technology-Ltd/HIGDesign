import HIGDesign
import SwiftUI

struct ShowcaseActivityIndicatorView: View {
    private let customStyles: [HIGActivityIndicatorStyle] = [
        .orbital, .pulsing, .arcs, .rotatingDots, .flickeringDots,
        .scalingDots, .opacityDots, .equalizer, .growingCircle, .gradient,
    ]

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
                        ForEach(customStyles, id: \.self) { style in
                            HIGActivityIndicator(style.showcaseLabel, size: .medium, style: style)
                        }
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

private extension HIGActivityIndicatorStyle {
    var showcaseLabel: String {
        switch self {
        case .system: "System"
        case .orbital: "Orbital"
        case .pulsing: "Pulsing"
        case .arcs: "Arcs"
        case .rotatingDots: "Rotating dots"
        case .flickeringDots: "Flickering dots"
        case .scalingDots: "Scaling dots"
        case .opacityDots: "Opacity dots"
        case .equalizer: "Equalizer"
        case .growingCircle: "Growing circle"
        case .gradient: "Gradient"
        }
    }
}

#if DEBUG
#Preview("ShowcaseActivityIndicatorView") {
    ShowcaseActivityIndicatorView()
}
#endif