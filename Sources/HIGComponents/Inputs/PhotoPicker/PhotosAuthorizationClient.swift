#if os(iOS)
import Foundation
import Photos

/// Authorization status mirrored from PhotoKit for testability.
public enum HIGPhotoAuthorizationStatus: Int, Equatable, Sendable {
    case notDetermined
    case restricted
    case denied
    case authorized
    case limited

    public var canBrowseLibrary: Bool {
        self == .authorized || self == .limited
    }
}

public protocol PhotosAuthorizationClientProtocol: Sendable {
    func currentStatus() -> HIGPhotoAuthorizationStatus
    func requestAuthorization() async -> HIGPhotoAuthorizationStatus
}

public struct PhotosAuthorizationClient: PhotosAuthorizationClientProtocol {
    public init() {}

    public func currentStatus() -> HIGPhotoAuthorizationStatus {
        resolvedAuthorizationStatus()
    }

    public func requestAuthorization() async -> HIGPhotoAuthorizationStatus {
        #if DEBUG
        if !HIGPhotoPickerRuntime.shouldAccessPhotoKit {
            return .authorized
        }
        #endif

        let existing = currentStatus()
        guard existing == .notDetermined else { return existing }

        return await withCheckedContinuation { continuation in
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                continuation.resume(returning: map(status))
            }
        }
    }

    private func resolvedAuthorizationStatus() -> HIGPhotoAuthorizationStatus {
        #if DEBUG
        if !HIGPhotoPickerRuntime.shouldAccessPhotoKit {
            return .authorized
        }
        #endif

        if #available(iOS 14, *) {
            let readWriteStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            if readWriteStatus != .notDetermined {
                return map(readWriteStatus)
            }
        }
        return map(PHPhotoLibrary.authorizationStatus())
    }

}

public extension HIGPhotoAuthorizationStatus {
    /// Returns the current photo-library authorization status for the host app.
    static var current: HIGPhotoAuthorizationStatus {
        PhotosAuthorizationClient().currentStatus()
    }
}

private extension PhotosAuthorizationClient {
    func map(_ status: PHAuthorizationStatus) -> HIGPhotoAuthorizationStatus {
        switch status {
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        case .denied: return .denied
        case .authorized: return .authorized
        case .limited: return .limited
        @unknown default: return .notDetermined
        }
    }
}#endif
