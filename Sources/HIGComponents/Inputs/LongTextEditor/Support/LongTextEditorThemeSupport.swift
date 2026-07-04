import HIGThemesContract
import HIGTokensComponent
import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

enum LongTextEditorThemeSupport {
    static func editorCSS(theme: any HIGTheme, tokens: any HIGLongTextEditorTokens) -> String {
        let colors = theme.colors
        let foreground = cssColor(colors.labelPrimary)
        let background = cssColor(colors.backgroundSecondary)
        let link = cssColor(colors.accent)

        return """
        body {
            color: \(foreground);
            background-color: \(background);
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", sans-serif;
            font-size: \(tokens.editorFontSize)px;
            line-height: \(tokens.editorLineHeight);
            margin: 0;
            padding: \(tokens.verticalPadding)px \(tokens.horizontalPadding)px;
        }
        a { color: \(link); }
        """
    }

    private static func cssColor(_ color: Color) -> String {
        #if canImport(UIKit)
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return String(format: "rgba(%d, %d, %d, %.2f)", Int(red * 255), Int(green * 255), Int(blue * 255), alpha)
        #elseif canImport(AppKit)
        let nsColor = NSColor(color)
        guard let rgb = nsColor.usingColorSpace(.deviceRGB) else { return "inherit" }
        return String(
            format: "rgba(%d, %d, %d, %.2f)",
            Int(rgb.redComponent * 255),
            Int(rgb.greenComponent * 255),
            Int(rgb.blueComponent * 255),
            rgb.alphaComponent
        )
        #else
        return "inherit"
        #endif
    }
}