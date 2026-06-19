import SwiftUI

struct ShowcaseDynamicTypeSizeModifier: ViewModifier {
    let choice: ShowcaseDynamicTypeSizeChoice

    func body(content: Content) -> some View {
        if let dynamicTypeSize = choice.dynamicTypeSize {
            content.dynamicTypeSize(dynamicTypeSize)
        } else {
            content
        }
    }
}