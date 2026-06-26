@testable import HIGIcons
import HIGThemesSystem
import XCTest

final class HIGHeroIconTests: XCTestCase {
    func testAcademicCapTokenRawValue() {
        XCTAssertEqual(HIGHeroIconToken.academicCap.rawValue, "academic-cap")
    }

    func testAllCasesCount() {
        XCTAssertEqual(HIGHeroIconToken.allCases.count, 324)
    }

    func testOutlineCatalogEntryExists() {
        XCTAssertNotNil(HIGHeroIconCatalog.entry(for: .academicCap, variant: .outline))
    }

    func testSolidCatalogEntryExists() {
        XCTAssertNotNil(HIGHeroIconCatalog.entry(for: .academicCap, variant: .solid))
    }

    func testThemeResolvesOutlineDescriptor() {
        let theme = HIGSystemTheme()
        let descriptor = theme.outlineIcon(from: .academicCap)

        XCTAssertEqual(descriptor.token, .academicCap)
        XCTAssertEqual(descriptor.variant, .outline)
    }

    func testThemeResolvesSolidDescriptor() {
        let theme = HIGSystemTheme()
        let descriptor = theme.solidIcon(from: .bell)

        XCTAssertEqual(descriptor.token, .bell)
        XCTAssertEqual(descriptor.variant, .solid)
    }

    @MainActor
    func testThemeManagerResolvesOutlineDescriptor() {
        HIGThemeManager.register(HIGSystemTheme())
        let descriptor = HIGThemeManager.outlineIcon(from: .academicCap)

        XCTAssertEqual(descriptor.token, .academicCap)
        XCTAssertEqual(descriptor.variant, .outline)
    }
}