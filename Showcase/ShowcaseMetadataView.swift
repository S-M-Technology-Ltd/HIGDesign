import SwiftUI

struct ShowcaseMetadataView: View {
    let component: ShowcaseComponent

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(component.summary)
                .font(.body)

            Group {
                Text("HIG: \(component.higReference)")
                Text("Platforms: \(component.platforms)")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview("ShowcaseMetadataView") {
    ShowcaseMetadataView(component: .button)
        .padding()
}
#endif