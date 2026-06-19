import Foundation

/// One selectable option in ``HIGRadio``.
public struct HIGRadioOption<Value: Hashable & Sendable>: Identifiable, Sendable {
    public let value: Value
    public let label: String

    public var id: Value { value }

    public init(value: Value, label: String) {
        self.value = value
        self.label = label
    }
}