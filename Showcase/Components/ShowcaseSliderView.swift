import HIGDesign
import SwiftUI

struct ShowcaseSliderView: View {
    @Environment(\.higTheme) private var theme
    @State private var volume = 60.0
    @State private var brightness = 0.75

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .slider)

                VStack(spacing: theme.spacing.section) {
                    ShowcaseSampleView(code: "HIGSlider(\"Volume\", value: $volume, in: 0 ... 100, step: 1)") {
                        HIGSlider("Volume", value: $volume, in: 0 ... 100, step: 1)
                    }
                    ShowcaseSampleView(code: "HIGSlider(\"Brightness\", value: $brightness, in: 0 ... 1, step: 0.05)") {
                        HIGSlider("Brightness", value: $brightness, in: 0 ... 1, step: 0.05)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Slider")
    }
}

#if DEBUG
#Preview("ShowcaseSliderView") {
    ShowcasePreviewContainer {
        ShowcaseSliderView()
    }
}
#endif