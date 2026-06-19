import SwiftUI

/// Renders one of two views based on a Boolean condition.
public struct HIGConditionalView<TrueContent: View, FalseContent: View>: View {
    private let condition: Bool
    private let trueContent: TrueContent
    private let falseContent: FalseContent

    public init(
        _ condition: Bool,
        @ViewBuilder if ifContent: () -> TrueContent,
        @ViewBuilder else elseContent: () -> FalseContent
    ) {
        self.condition = condition
        self.trueContent = ifContent()
        self.falseContent = elseContent()
    }

    public var body: some View {
        if condition {
            trueContent
        } else {
            falseContent
        }
    }
}

public extension View {
    /// Applies one of two view builders based on a Boolean condition.
    @ViewBuilder
    func higConditional<TrueContent: View, FalseContent: View>(
        _ condition: Bool,
        @ViewBuilder if ifContent: () -> TrueContent,
        @ViewBuilder else elseContent: () -> FalseContent
    ) -> some View {
        if condition {
            ifContent()
        } else {
            elseContent()
        }
    }
}

#if DEBUG
#Preview("HIGConditionalView") {
    HIGConditionalView(true) {
        Text("Enabled")
    } else: {
        Text("Disabled")
    }
    .padding()
}
#endif