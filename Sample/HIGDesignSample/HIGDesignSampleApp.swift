import HIGShowcase
import SwiftUI

@main
struct HIGDesignSampleApp: App {
    var body: some Scene {
        WindowGroup {
            ShowcaseRootView()
        }
        #if os(macOS)
        .defaultSize(width: 1200, height: 800)
        #endif
    }
}