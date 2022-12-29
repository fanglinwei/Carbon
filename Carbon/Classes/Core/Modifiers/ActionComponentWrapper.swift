//
//  ActionComponentWrapper.swift
//  Carbon
//
//  Created by 方林威 on 2022/12/29.
//  Copyright © 2022 Ryo Aoyama. All rights reserved.
//

import Foundation
/// A wrapper around the compoent to conform to `IdentifiableComponent`.
public struct ActionComponentWrapper<Wrapped: Component>: ComponentWrapping, ActionComponent {
    
    public var action: Action?
    
    /// The wrapped component instance.
    public var wrapped: Wrapped

    /// Create a component wrapper wrapping given id and component.
    ///
    /// - Parameters:
    ///   - id: An identifier to be wrapped.
    ///   - wrapped: A compoennt instance to be wrapped.
    public init(wrapped: Wrapped, action: @escaping Action) {
        self.wrapped = wrapped
        self.action = action
    }
    
    public func contentDidSelected(_ content: Wrapped.Content) {
        wrapped.contentDidSelected(content)
        action?(content)
    }
}

public extension Component {
    
    func onTap(_ value: @escaping (() -> Void)) -> ActionComponentWrapper<Self> {
        ActionComponentWrapper(wrapped: self) { _ in
            value()
        }
    }
    
    func onTap<S>(on target: S, _ value: @escaping (S) -> Void) -> ActionComponentWrapper<Self> {
        onTap { value(target) }
    }
    
    func onTap<S>(on target: S, _ value: @escaping (S) -> Void) -> ActionComponentWrapper<Self> where S: AnyObject {
        onTap { [weak target] in
            guard let target = target else { return }
            value(target)
        }
    }
}

extension ActionComponentWrapper: Identifiable & CellsBuildable where Wrapped: Identifiable & CellsBuildable {
    public var id: Wrapped.ID { wrapped.id }
}

extension ActionComponentWrapper: CarbonUnit where Wrapped: CarbonUnit { }
