import SwiftUI

enum ShowcaseDynamicTypeSizeChoice: String, CaseIterable, Identifiable, Sendable {
    case system
    case large
    case xLarge
    case accessibility1
    case accessibility3

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system:
            "System"
        case .large:
            "Large"
        case .xLarge:
            "Extra Large"
        case .accessibility1:
            "Accessibility 1"
        case .accessibility3:
            "Accessibility 3"
        }
    }

    var dynamicTypeSize: DynamicTypeSize? {
        switch self {
        case .system:
            nil
        case .large:
            .large
        case .xLarge:
            .xLarge
        case .accessibility1:
            .accessibility1
        case .accessibility3:
            .accessibility3
        }
    }
}