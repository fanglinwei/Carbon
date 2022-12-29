public protocol ActionComponent: Component {
    
    typealias Action = ((Content) -> Void)
    
    var action: Action? { get set }
    
    func onTap<S>(on target: S, _ value: @escaping (S) -> Void) -> Self
    func onTap<S>(on target: S, _ value: @escaping (S) -> Void) -> Self where S: AnyObject
}

public extension ActionComponent {
    
    func onTap(_ value: @escaping (() -> Void)) -> Self {
        reform { $0.action = { _ in value() } }
    }
    
    func onTap<S>(on target: S, _ value: @escaping (S) -> Void) -> Self {
        onTap { value(target) }
    }
    
    func onTap<S>(on target: S, _ value: @escaping (S) -> Void) -> Self where S: AnyObject {
        onTap { [weak target] in
            guard let target = target else { return }
            value(target)
        }
    }
    
    private func reform(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}
