@testable import HIGIcons
import HIGThemesContract
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

    func testHomeOutlinePathFitsViewBox() {
        guard let entry = HIGHeroIconCatalog.entry(for: .home, variant: .outline) else {
            return XCTFail("Missing home outline catalog entry")
        }

        let combined = CGMutablePath()
        for pathEntry in entry.paths {
            combined.addPath(
                HIGSVGPathParser.makePath(
                    from: pathEntry.d,
                    in: CGRect(origin: .zero, size: CGSize(width: 24, height: 24))
                )
            )
        }

        let bounds = combined.boundingBox
        XCTAssertGreaterThan(bounds.width, 0)
        XCTAssertGreaterThan(bounds.height, 0)
        XCTAssertLessThanOrEqual(bounds.maxX, 24.5)
        XCTAssertLessThanOrEqual(bounds.maxY, 24.5)
        XCTAssertGreaterThanOrEqual(bounds.minX, -0.5)
        XCTAssertGreaterThanOrEqual(bounds.minY, -0.5)
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
        HIGThemeRegistration.register(HIGSystemTheme())
        let descriptor = HIGThemeManager.outlineIcon(from: .academicCap)

        XCTAssertEqual(descriptor.token, .academicCap)
        XCTAssertEqual(descriptor.variant, .outline)
    }

    @MainActor
    func testThemeRegistrationStoresCurrentTheme() {
        let theme = HIGSystemTheme()
        HIGThemeRegistration.register(theme)
        XCTAssertTrue(HIGThemeRegistration.currentTheme is HIGSystemTheme)
        XCTAssertEqual(HIGThemeManager.current.name, theme.name)
    }
}