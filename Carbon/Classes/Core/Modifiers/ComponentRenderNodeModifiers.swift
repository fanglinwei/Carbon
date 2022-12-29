//
//  ViewRenderNodeModifiers.swift
//  Example-iOS
//
//  Created by 方林威 on 2022/12/13.
//  Copyright © 2022 Ryo Aoyama. All rights reserved.
//

import UIKit

public struct ComponentUpdateRenderNode<Wrapped: Component>: ComponentWrapping {
    
    public var wrapped: Wrapped
    
    public let update: (Wrapped.Content) -> Void
    
    public func render(in content: Wrapped.Content) {
        wrapped.render(in: content)
        update(content)
    }
}

public struct ComponentKeyPathUpdateRenderNode<Value, Wrapped: Component>: ComponentWrapping {
    public var wrapped: Wrapped
    public let valueKeyPath: ReferenceWritableKeyPath<Wrapped.Content, Value>
    public let value: Value
    
    public func render(in content: Wrapped.Content) {
        wrapped.render(in: content)
        content[keyPath: valueKeyPath] = value
    }
}

extension Component {

    subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<Content, Value>) -> (Value) -> ComponentKeyPathUpdateRenderNode<Value, Self> {
        { with(keyPath, $0) }
    }
    
    public func with<Value>(_ keyPath: ReferenceWritableKeyPath<Content, Value>, _ value: Value) -> ComponentKeyPathUpdateRenderNode<Value, Self> {
        ComponentKeyPathUpdateRenderNode(wrapped: self, valueKeyPath: keyPath, value: value)
    }
    
    public func update(_ update: @escaping (Content) -> Void) -> ComponentUpdateRenderNode<Self> {
        ComponentUpdateRenderNode(wrapped: self, update: update)
    }
}

/// Identifiable & CellsBuildable
extension ComponentUpdateRenderNode: Identifiable & CellsBuildable where Wrapped: Identifiable & CellsBuildable {
    public var id: Wrapped.ID { wrapped.id }
}

extension ComponentKeyPathUpdateRenderNode: Identifiable & CellsBuildable where Wrapped: Identifiable & CellsBuildable {
    public var id: Wrapped.ID { wrapped.id }
    
}

extension Component where Self: Identifiable & CellsBuildable {
    
    subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<Content, Value>) -> (Value) -> ComponentKeyPathUpdateRenderNode<Value, Self> {
        { with(keyPath, $0) }
    }
    
    public func with<Value>(_ keyPath: ReferenceWritableKeyPath<Content, Value>, _ value: Value) -> ComponentKeyPathUpdateRenderNode<Value, Self> {
        ComponentKeyPathUpdateRenderNode(wrapped: self, valueKeyPath: keyPath, value: value)
    }
    
    public func update(_ update: @escaping (Content) -> Void) -> ComponentUpdateRenderNode<Self> {
        ComponentUpdateRenderNode(wrapped: self, update: update)
    }
}

extension ComponentUpdateRenderNode: CarbonUnit where Wrapped: CarbonUnit { }
extension ComponentKeyPathUpdateRenderNode: CarbonUnit where Wrapped: CarbonUnit { }

