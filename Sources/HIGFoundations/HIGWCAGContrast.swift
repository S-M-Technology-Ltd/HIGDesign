import Foundation

public enum HIGWCAGContrast {
    public static func relativeLuminance(red: Double, green: Double, blue: Double) -> Double {
        func channel(_ value: Double) -> Double {
            if value <= 0.03928 {
                return value / 12.92
            }
            return pow((value + 0.055) / 1.055, 2.4)
        }

        let redChannel = channel(red)
        let greenChannel = channel(green)
        let blueChannel = channel(blue)
        return 0.2126 * redChannel + 0.7152 * greenChannel + 0.0722 * blueChannel
    }

    public static func contrastRatio(lighter: Double, darker: Double) -> Double {
        let lighterValue = max(lighter, darker)
        let darkerValue = min(lighter, darker)
        return (lighterValue + 0.05) / (darkerValue + 0.05)
    }

    public static func meetsWCAGAA(foreground: Double, background: Double) -> Bool {
        contrastRatio(lighter: foreground, darker: background) >= 4.5
    }
}