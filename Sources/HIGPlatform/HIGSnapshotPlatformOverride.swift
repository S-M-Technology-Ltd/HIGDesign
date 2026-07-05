import HIGFoundations

/// Optional idiom override used while rendering showcase snapshots off-device.
public enum HIGSnapshotPlatformOverride: Sendable {
    nonisolated(unsafe) public static var idiom: HIGUserInterfaceIdiom?

    @MainActor
    public static func using<T>(
        _ idiom: HIGUserInterfaceIdiom?,
        perform work: () throws -> T
    ) rethrows -> T {
        let previous = self.idiom
        self.idiom = idiom
        defer { self.idiom = previous }
        return try work()
    }
}