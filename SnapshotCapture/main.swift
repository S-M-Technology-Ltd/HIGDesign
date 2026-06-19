import HIGShowcase

@main
@MainActor
enum HIGSnapshotCaptureMain {
    static func main() {
        #if os(macOS)
        ShowcaseSnapshotCapture.run()
        #else
        print("Showcase snapshot capture requires macOS.")
        #endif
    }
}