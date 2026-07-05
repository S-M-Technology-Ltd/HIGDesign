#if os(iOS)
import CoreGraphics
import Foundation

enum ImageCacheKey {
    static func thumbnail(assetID: String, targetSize: CGSize) -> String {
        "\(assetID)-\(Int(targetSize.width))x\(Int(targetSize.height))"
    }
}

/// Thread-safe image cache for grid and preview thumbnails (no Swift actors — avoids executor hops from UIKit cells).
final class ImageCache: @unchecked Sendable {
    static let shared = ImageCache()

    private let lock = NSLock()
    private let cache = NSCache<NSString, CGImage>()
    private var assetKeys: [String: String] = [:]

    init() {
        cache.countLimit = 300
        cache.totalCostLimit = 64 * 1024 * 1024
    }

    func image(for key: String) -> CGImage? {
        lock.lock()
        defer { lock.unlock() }
        return cache.object(forKey: key as NSString)
    }

    func imageForAssetID(_ assetID: String) -> CGImage? {
        lock.lock()
        defer { lock.unlock() }
        guard let key = assetKeys[assetID] else { return nil }
        return cache.object(forKey: key as NSString)
    }

    func insert(_ image: CGImage, for key: String, assetID: String? = nil) {
        let cost = image.bytesPerRow * image.height
        lock.lock()
        defer { lock.unlock() }
        cache.setObject(image, forKey: key as NSString, cost: cost)
        if let assetID {
            assetKeys[assetID] = key
        }
    }

    func remove(for key: String) {
        lock.lock()
        defer { lock.unlock() }
        cache.removeObject(forKey: key as NSString)
    }

    func removeAll() {
        lock.lock()
        defer { lock.unlock() }
        cache.removeAllObjects()
        assetKeys.removeAll()
    }
}
#endif