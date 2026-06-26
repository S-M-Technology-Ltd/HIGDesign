import HIGDesign
import SwiftUI

enum ShowcaseIconFamily: String, CaseIterable, Identifiable, Sendable {
    case sfSymbol
    case heroicon

    var id: String { rawValue }

    var title: String {
        switch self {
        case .sfSymbol:
            "SF Symbol"
        case .heroicon:
            "Heroicon"
        }
    }
}

enum ShowcaseIconSizeChoice: String, CaseIterable, Identifiable, Sendable {
    case small
    case medium
    case large
    case fixed

    var id: String { rawValue }

    var title: String {
        switch self {
        case .small:
            "Small"
        case .medium:
            "Medium"
        case .large:
            "Large"
        case .fixed:
            "Fixed"
        }
    }

    func higSize(fixedPoints: CGFloat) -> HIGIconSize {
        switch self {
        case .small:
            .small
        case .medium:
            .medium
        case .large:
            .large
        case .fixed:
            .fixed(fixedPoints)
        }
    }
}

enum ShowcaseIconStyleChoice: String, CaseIterable, Identifiable, Sendable {
    case primary
    case secondary
    case accent
    case tint

    var id: String { rawValue }

    var title: String {
        switch self {
        case .primary:
            "Primary"
        case .secondary:
            "Secondary"
        case .accent:
            "Accent"
        case .tint:
            "Custom Tint"
        }
    }

    func higStyle(customTint: Color) -> HIGIconStyle {
        switch self {
        case .primary:
            .primary
        case .secondary:
            .secondary
        case .accent:
            .accent
        case .tint:
            .tint(customTint)
        }
    }
}

enum ShowcaseHeroiconTokenChoice: String, CaseIterable, Identifiable, Sendable {
    case academicCap
    case bell
    case heart
    case star
    case home
    case user
    case cog6Tooth
    case magnifyingGlass
    case check
    case xMark
    case arrowRight
    case envelope

    var id: String { rawValue }

    var title: String {
        switch self {
        case .academicCap:
            "Academic Cap"
        case .bell:
            "Bell"
        case .heart:
            "Heart"
        case .star:
            "Star"
        case .home:
            "Home"
        case .user:
            "User"
        case .cog6Tooth:
            "Cog"
        case .magnifyingGlass:
            "Search"
        case .check:
            "Check"
        case .xMark:
            "Close"
        case .arrowRight:
            "Arrow Right"
        case .envelope:
            "Envelope"
        }
    }

    var token: HIGHeroIconToken {
        switch self {
        case .academicCap:
            .academicCap
        case .bell:
            .bell
        case .heart:
            .heart
        case .star:
            .star
        case .home:
            .home
        case .user:
            .user
        case .cog6Tooth:
            .cog6Tooth
        case .magnifyingGlass:
            .magnifyingGlass
        case .check:
            .check
        case .xMark:
            .xMark
        case .arrowRight:
            .arrowRight
        case .envelope:
            .envelope
        }
    }
}

struct ShowcaseIconSettings: Equatable {
    /// Upper bound for the Icon playground fixed-size slider.
    static let maxFixedSize: Double = 512

    var family: ShowcaseIconFamily = .heroicon
    var sfSymbolName = "bell.fill"
    var heroiconToken: ShowcaseHeroiconTokenChoice = .academicCap
    var heroiconVariant: HIGHeroIconVariant = .outline
    var sizeChoice: ShowcaseIconSizeChoice = .medium
    var fixedSize: Double = 28
    var styleChoice: ShowcaseIconStyleChoice = .primary
    var customTint: Color = .orange

    var higSize: HIGIconSize {
        sizeChoice.higSize(fixedPoints: CGFloat(fixedSize))
    }

    var higStyle: HIGIconStyle {
        styleChoice.higStyle(customTint: customTint)
    }
}