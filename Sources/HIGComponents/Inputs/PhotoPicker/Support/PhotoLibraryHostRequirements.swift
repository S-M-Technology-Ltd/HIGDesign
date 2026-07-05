#if os(iOS)
import Foundation

protocol InfoPlistReading: Sendable {
    func object(forInfoDictionaryKey key: String) -> Any?
}

extension Bundle: InfoPlistReading {}

/// Required host-app Info.plist keys for a smooth photo-library experience.
public enum PhotoLibraryHostRequirements: Sendable {
    public static let photoLibraryUsageDescriptionKey = "NSPhotoLibraryUsageDescription"
    public static let preventAutomaticLimitedAccessAlertKey = "PHPhotoLibraryPreventAutomaticLimitedAccessAlert"

    public struct ValidationResult: Equatable, Sendable {
        public let missingKeys: [String]

        public var isValid: Bool { missingKeys.isEmpty }
    }

    /// Validates that the host application Info.plist includes keys required by HIGPhotoPicker.
    public static func validateHostInfoPlist(bundle: Bundle = .main) -> ValidationResult {
        validateHostInfoPlist(reader: bundle)
    }

    static func validateHostInfoPlist(reader: some InfoPlistReading) -> ValidationResult {
        let requiredKeys = [
            photoLibraryUsageDescriptionKey,
            preventAutomaticLimitedAccessAlertKey,
        ]

        let missingKeys = requiredKeys.filter { key in
            guard let value = reader.object(forInfoDictionaryKey: key) else { return true }
            return !isValidPlistValue(value, for: key)
        }

        return ValidationResult(missingKeys: missingKeys)
    }

    private static func isValidPlistValue(_ value: Any, for key: String) -> Bool {
        if let string = value as? String {
            return !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        if let bool = value as? Bool {
            return key != preventAutomaticLimitedAccessAlertKey || bool
        }
        if let number = value as? NSNumber {
            return key != preventAutomaticLimitedAccessAlertKey || number.boolValue
        }
        return true
    }

    static func logMissingRequirementsIfNeeded(
        for status: HIGPhotoAuthorizationStatus,
        bundle: Bundle = .main
    ) {
        #if DEBUG
        guard status == .limited else { return }
        guard !HIGPhotoPickerRuntime.isRunningInXcodePreview else { return }

        let validation = validateHostInfoPlist(bundle: bundle)
        guard !validation.isValid else { return }

        let keys = validation.missingKeys.joined(separator: ", ")
        let bundleID = bundle.bundleIdentifier ?? "unknown"
        print(
            """
            HIGPhotoPicker warning: Missing host Info.plist keys: \(keys).
            Host bundle: \(bundleID)
            Users with Limited Photos access may see a system photo-access sheet every time the picker opens.
            Add the keys to your app target's Info.plist (not the Swift package), then Clean Build Folder and reinstall the app.
            """
        )
        #endif
    }
}
#endif