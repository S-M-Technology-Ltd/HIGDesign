import HIGComponents
import SwiftUI

public extension View {
    /// Applies a HIG-aligned toolbar using native SwiftUI toolbar placements.
    func higToolbar<Content: ToolbarContent>(
        @ToolbarContentBuilder _ content: () -> Content
    ) -> some View {
        HIGToolbar(content: { self }, toolbar: content)
    }
}