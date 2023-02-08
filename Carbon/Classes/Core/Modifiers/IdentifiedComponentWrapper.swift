/// A wrapper around the compoent to conform to `IdentifiableComponent`.
public struct IdentifiedComponentWrapper<ID: Hashable, Wrapped: Component>: ComponentWrapping, Identifiable {
    /// A type that represents an id that used to uniquely identify the component.
    public var id: ID

    /// The wrapped component instance.
    public var wrapped: Wrapped

    /// Create a component wrapper wrapping given id and component.
    ///
    /// - Parameters:
    ///   - id: An identifier to be wrapped.
    ///   - wrapped: A compoennt instance to be wrapped.
    public init(id: ID, wrapped: Wrapped) {
        self.id = id
        self.wrapped = wrapped
    }
}

public extension Component {
    /// Returns an identified component wrapping `self` and given `id`.
    /// - Parameter:
    ///   - id: An identifier to be wrapped.
    ///
    /// - Returns: An identified component wrapping `self` and given `id`.
    func identified<ID: Hashable>(_ id: ID = UniqueIdentifier()) -> IdentifiedComponentWrapper<ID, Self> {
        return IdentifiedComponentWrapper(id: id, wrapped: self)
    }

    /// Returns an identified component wrapping `self` and the `id` that accessed by given key path.
    /// - Parameter:
    ///   - keyPath: A key path to access an identifier of the `self`.
    ///
    /// - Returns: An identified component wrapping `self` and the `id` that accessed by given key path.
    func identified<ID: Hashable>(_ keyPath: KeyPath<Self, ID>) -> IdentifiedComponentWrapper<ID, Self> {
        return identified(self[keyPath: keyPath])
    }
}

extension IdentifiedComponentWrapper: CarbonUnit { }
//extension IdentifiedComponentWrapper: CarbonUnit where Wrapped: CarbonUnit { }
