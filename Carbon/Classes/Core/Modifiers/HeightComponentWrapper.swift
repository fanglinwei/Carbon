//
//  HeightComponentWrapper.swift
//  Carbon
//
//  Created by 方林威 on 2022/12/29.
//  Copyright © 2022 Ryo Aoyama. All rights reserved.
//

import UIKit
/// A wrapper around the compoent to conform to `IdentifiableComponent`.
public struct HeightComponentWrapper<Wrapped: Component>: ComponentWrapping, HeightComponent {
    public var size: ComponentSize?
    
    /// The wrapped component instance.
    public var wrapped: Wrapped

    /// Create a component wrapper wrapping given id and component.
    ///
    /// - Parameters:
    ///   - id: An identifier to be wrapped.
    ///   - wrapped: A compoennt instance to be wrapped.
    public init(wrapped: Wrapped, size: ComponentSize?) {
        self.wrapped = wrapped
        self.size = size
    }
    
    public func referenceSize(in bounds: CGRect) -> CGSize? {
        switch size {
        case .automaticDimension:       return CGSize(width: bounds.width, height: UITableView.automaticDimension)
        case .constant(let value):      return CGSize(width: bounds.width, height: value)
        case .size(let value):          return value
        case .none:                     return wrapped.referenceSize(in: bounds)
        }
    }
}

public extension Component {
    
    func height(_ value: ComponentSize?) -> HeightComponentWrapper<Self> {
        HeightComponentWrapper(wrapped: self, size: value)
    }
    
    func height(_ value: @autoclosure () -> (CGFloat)) -> HeightComponentWrapper<Self> {
        height(.constant(value()))
    }
}


extension HeightComponentWrapper: Identifiable & CellsBuildable where Wrapped: Identifiable & CellsBuildable {
    
    public var id: Wrapped.ID { wrapped.id }
}

extension HeightComponentWrapper: CarbonUnit where Wrapped: CarbonUnit { }

