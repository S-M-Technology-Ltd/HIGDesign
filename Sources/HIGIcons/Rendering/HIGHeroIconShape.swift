import CoreGraphics
import SwiftUI

struct HIGHeroIconShape: Shape {
    let token: HIGHeroIconToken
    let variant: HIGHeroIconVariant

    func path(in rect: CGRect) -> Path {
        guard let entry = HIGHeroIconCatalog.entry(for: token, variant: variant) else {
            return Path()
        }

        let combined = CGMutablePath()
        for pathEntry in entry.paths {
            let subpath = HIGSVGPathParser.makePath(from: pathEntry.d, in: rect)
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