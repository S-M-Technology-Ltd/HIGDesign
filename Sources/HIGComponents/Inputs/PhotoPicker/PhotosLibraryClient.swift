#if os(iOS)
import Foundation
import Photos

public struct HIGPhotoAlbum: Identifiable, Equatable, Sendable {
    public let id: String
    public let name: String
    public let assetCount: Int

    public init(id: String, name: String, assetCount: Int) {
        self.id = id
        self.name = name
        self.assetCount = assetCount
    }

    public init(collection: PHAssetCollection, assetCount: Int) {
        self.id = collection.localIdentifier
        self.name = collection.localizedTitle ?? ""
        self.assetCount = assetCount
    }
}

public protocol PhotosLibraryClientProtocol: Sendable {
    func fetchAlbums(allowedMediaTypes: Set<PHAssetMediaType>) async -> [HIGPhotoAlbum]
    func fetchAssets(
        in albumID: String,
        allowedMediaTypes: Set<PHAssetMediaType>
    ) async -> [HIGPhotoAsset]
    func fetchAsset(localIdentifier: String) async -> HIGPhotoAsset?
}

private actor PhotosLibraryExecutor {
    func perform<T: Sendable>(_ work: @Sendable () -> T) -> T {
        work()
    }
}

public struct PhotosLibraryClient: PhotosLibraryClientProtocol {
    private static let executor = PhotosLibraryExecutor()

    public init() {}

    public func fetchAlbums(allowedMediaTypes: Set<PHAssetMediaType>) async -> [HIGPhotoAlbum] {
        #if DEBUG
        guard HIGPhotoPickerRuntime.shouldAccessPhotoKit else { return [] }
        #endif

        return await Self.executor.perform {
            var albums: [HIGPhotoAlbum] = []

            for type in [PHAssetCollectionType.smartAlbum, .album] {
                let collections = PHAssetCollection.fetchAssetCollections(with: type, subtype: .any, options: nil)
                collections.enumerateObjects { collection, _, _ in
                    guard collection.localizedTitle != nil else { return }
                    let count = Self.fetchPHAssets(in: collection, allowedMediaTypes: allowedMediaTypes).count
                    guard count > 0 else { return }
                    albums.append(HIGPhotoAlbum(collection: collection, assetCount: count))
                }
            }

            return albums
        }
    }

    public func fetchAssets(
        in albumID: String,
        allowedMediaTypes: Set<PHAssetMediaType>
    ) async -> [HIGPhotoAsset] {
        #if DEBUG
        guard HIGPhotoPickerRuntime.shouldAccessPhotoKit else { return [] }
        #endif

        return await Self.executor.perform {
            let collections = PHAssetCollection.fetchAssetCollections(
                withLocalIdentifiers: [albumID],
                options: nil
            )
            guard let collection = collections.firstObject else { return [] }
            return Self.mapAssetsLightweight(
                Self.fetchPHAssets(in: collection, allowedMediaTypes: allowedMediaTypes)
            )
        }
    }

    public func fetchAsset(localIdentifier: String) async -> HIGPhotoAsset? {
        #if DEBUG
        guard HIGPhotoPickerRuntime.shouldAccessPhotoKit else { return nil }
        #endif

        return await Self.executor.perform {
            guard let phAsset = PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifier], options: nil).firstObject else {
                return nil
            }
            return phAsset.makeDetailedAsset()
        }
    }

    private static func fetchPHAssets(
        in collection: PHAssetCollection,
        allowedMediaTypes: Set<PHAssetMediaType>
    ) -> PHFetchResult<PHAsset> {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        options.predicate = mediaPredicate(for: allowedMediaTypes)
        return PHAsset.fetchAssets(in: collection, options: options)
    }

    private static func mediaPredicate(for types: Set<PHAssetMediaType>) -> NSPredicate? {
        let rawValues = types.map(\.rawValue)
        guard !rawValues.isEmpty else { return nil }
        return NSPredicate(format: "mediaType IN %@", rawValues)
    }

    private static func mapAssetsLightweight(_ fetchResult: PHFetchResult<PHAsset>) -> [HIGPhotoAsset] {
        var assets: [HIGPhotoAsset] = []
        assets.reserveCapacity(fetchResult.count)
        fetchResult.enumerateObjects { asset, _, _ in
            assets.append(asset.makeLightweightAsset())
        }
        return assets
    }
}
#endif