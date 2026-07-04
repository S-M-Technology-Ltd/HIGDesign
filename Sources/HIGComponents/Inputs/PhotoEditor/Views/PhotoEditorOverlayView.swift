#if os(iOS)
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

struct PhotoEditorOverlayView: View {
    let cropRegionSize: CGSize
    let canvasSize: CGSize
    let croppingStyle: HIGPhotoEditorCroppingStyle
    let showsCompositionGrid: Bool

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoEditorTokens { theme.photoEditor }

    var body: some View {
        let cropOrigin = CGPoint(
            x: (canvasSize.width - cropRegionSize.width) / 2,
            y: (canvasSize.height - cropRegionSize.height) / 2
        )
        let cropRect = CGRect(origin: cropOrigin, size: cropRegionSize)

        Canvas { context, size in
            var dimming = Path()
            dimming.addRect(CGRect(origin: .zero, size: size))

            switch croppingStyle {
            case .default:
                dimming.addRect(cropRect)
            case .circular:
                dimming.addEllipse(in: cropRect)
            }

            context.fill(
                dimming,
                with: .color(theme.colors.labelPrimary.opacity(tokens.overlayDimmingOpacity)),
                style: FillStyle(eoFill: true)
            )

            let borderColor = theme.colors.labelPrimary
            let stroke = StrokeStyle(lineWidth: tokens.cropBorderWidth)

            switch croppingStyle {
            case .default:
                context.stroke(Path(cropRect), with: .color(borderColor), style: stroke)
            case .circular:
                context.stroke(Path(ellipseIn: cropRect), with: .color(borderColor), style: stroke)
            }

            if showsCompositionGrid {
                let lineColor = theme.colors.labelPrimary.opacity(tokens.compositionGridLineOpacity)
                let gridStroke = StrokeStyle(lineWidth: tokens.compositionGridLineWidth)
                var grid = Path()

                let thirdWidth = cropRect.width / 3
                let thirdHeight = cropRect.height / 3

                grid.move(to: CGPoint(x: cropRect.minX + thirdWidth, y: cropRect.minY))
                grid.addLine(to: CGPoint(x: cropRect.minX + thirdWidth, y: cropRect.maxY))
                grid.move(to: CGPoint(x: cropRect.minX + thirdWidth * 2, y: cropRect.minY))
                grid.addLine(to: CGPoint(x: cropRect.minX + thirdWidth * 2, y: cropRect.maxY))
                grid.move(to: CGPoint(x: cropRect.minX, y: cropRect.minY + thirdHeight))
                grid.addLine(to: CGPoint(x: cropRect.maxX, y: cropRect.minY + thirdHeight))
                grid.move(to: CGPoint(x: cropRect.minX, y: cropRect.minY + thirdHeight * 2))
                grid.addLine(to: CGPoint(x: cropRect.maxX, y: cropRect.minY + thirdHeight * 2))

                context.stroke(grid, with: .color(lineColor), style: gridStroke)
            }
        }
        .allowsHitTesting(false)
    }
}
#endif