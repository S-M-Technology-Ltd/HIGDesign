#if os(iOS)
import Foundation
@testable import HIGComponents
import Testing

private struct MockInfoPlistReader: InfoPlistReading {
    let values: [String: Any]

    func object(forInfoDictionaryKey key: String) -> Any? {
        values[key]
    }
}

@Test
func photoLibraryHostRequirementsAcceptBooleanLimitedAccessKey() {
    let reader = MockInfoPlistReader(values: [
        PhotoLibraryHostRequirements.photoLibraryUsageDescriptionKey: "Photos",
        PhotoLibraryHostRequirements.preventAutomaticLimitedAccessAlertKey: true,
    ])

    let result = PhotoLibraryHostRequirements.validateHostInfoPlist(reader: reader)

    #expect(result.isValid)
}

@Test
func photoLibraryHostRequirementsRejectMissingLimitedAccessKey() {
    let reader = MockInfoPlistReader(values: [
        PhotoLibraryHostRequirements.photoLibraryUsageDescriptionKey: "Photos",
    ])

    let result = PhotoLibraryHostRequirements.validateHostInfoPlist(reader: reader)

    #expect(!result.isValid)
    #expect(result.missingKeys.contains(PhotoLibraryHostRequirements.preventAutomaticLimitedAccessAlertKey))
}
#endif