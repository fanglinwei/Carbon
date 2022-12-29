//
//  WrapperRow.swift
//  Example-iOS
//
//  Created by 方林威 on 2022/12/12.
//  Copyright © 2022 Ryo Aoyama. All rights reserved.
//

import UIKit

extension WrapperComponent: CarbonUnit {}

public struct WrapperComponent<Content: WrapperComponentable>: ActionComponent {
    
    public typealias Data = Content.Data
    
    public init(_ data: Data) {
        self.data = data
    }
    
    public init(_ data: Data, _ content: @escaping () -> Content) {
        self.data = data
        self.content = content
    }
    
    public var action: Action?
    
    private var data: Data
    
    private var update: ((Content, Data) -> Void)?
    
    private var content: (() -> Content)?
    
    public func renderContent() -> Content {
        content?() ?? Content()
    }

    public func render(in content: Content) {
        content.configure(with: data)

        update?(content, data)
    }
    
    public func contentDidSelected(_ content: Content) {
        action?(content)
    }
}


extension WrapperComponent: CellsBuildable & Identifiable where Content.Data: Hashable {
    
    public var id: Data { data }
    
    public func buildCells() -> [CellNode] {
        return [CellNode(id: id, self)]
    }
}

public extension WrapperComponent {

    func data(_ data: Data) -> Self {
        reform { $0.data = data }
    }

    func update(_ value: @escaping (Content, Data) -> Void) -> Self {
        reform { $0.update = value }
    }
    
    func onTap(_ value: @escaping ((Content, Data) -> Void)) -> Self {
        reform {
            $0.action = { content in
                value(content, data)
            }
        }
    }
    
    private func reform(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}

extension UIView {
    
    var flattendSubviews: [UIView] {
        subviews + subviews.flatMap { $0.flattendSubviews }
    }
}

public protocol WrapperComponentable: UIView {
    associatedtype Data
    func configure(with data: Data)
}

extension UILabel: WrapperComponentable {

    public func configure(with data: WrapperComponentData) {
        text = "\(data)"
    }
}

extension UIButton: WrapperComponentable {

    public func configure(with data: WrapperComponentData) {
        setTitle("\(data)", for: .normal)
    }
}

extension UISwitch: WrapperComponentable {

    public func configure(with data: Bool) {
        isOn = data
    }
}

public protocol WrapperComponentData {}
extension String: WrapperComponentData {}
extension Int: WrapperComponentData {}
extension Double: WrapperComponentData {}
extension Float: WrapperComponentData {}
extension Bool: WrapperComponentData {}
