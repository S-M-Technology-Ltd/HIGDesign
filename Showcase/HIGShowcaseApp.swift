import SwiftUI

@main
struct HIGShowcaseApp: App {
    var body: some Scene {
        WindowGroup {
            ShowcaseRootView()
        }
        #if os(macOS)
        .defaultSize(width: 1200, height: 800)
        #endif
    }
}