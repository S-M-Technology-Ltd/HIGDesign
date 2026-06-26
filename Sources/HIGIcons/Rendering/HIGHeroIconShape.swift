import CoreGraphics
import SwiftUI

enum HIGHeroIconMetrics {
    /// Heroicons v2 24pt assets use a 24×24 view box.
    static let viewBoxSize: CGFloat = 24
    static let viewBoxRect = CGRect(origin: .zero, size: CGSize(width: viewBoxSize, height: viewBoxSize))
}

struct HIGHeroIconShape: Shape {
    let token: HIGHeroIconToken
    let variant: HIGHeroIconVariant

    func path(in rect: CGRect) -> Path {
        guard let entry = HIGHeroIconCatalog.entry(for: token, variant: variant) else {
            return Path()
        }

        let combined = CGMutablePath()
        for pathEntry in entry.paths {
            let subpath = HIGSVGPathParser.makePath(
                from: pathEntry.d,
                in: HIGHeroIconMetrics.viewBoxRect
            )
            combined.addPath(subpath)
        }

        return Path(combined)
    }
}

extension HIGHeroIconCatalogEntry {
    var strokeWidth: CGFloat {
        paths.first?.strokeWidth ?? 1.5
    }
}