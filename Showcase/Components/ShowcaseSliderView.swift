import HIGDesign
import SwiftUI

struct ShowcaseSliderView: View {
    @State private var volume = 60.0
    @State private var brightness = 0.75

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .slider)

                VStack(spacing: 20) {
                    HIGSlider("Volume", value: $volume, in: 0 ... 100, step: 1)
                    HIGSlider("Brightness", value: $brightness, in: 0 ... 1, step: 0.05)
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Slider")
    }
}

#if DEBUG
#Preview("ShowcaseSliderView") {
    ShowcaseSliderView()
}
#endif