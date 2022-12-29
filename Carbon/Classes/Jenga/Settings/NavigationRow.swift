//
//  NavigationRow.swift
//  Carbon
//
//  Created by 方林威 on 2022/12/27.
//  Copyright © 2022 Ryo Aoyama. All rights reserved.
//

import UIKit

public struct NavigationRow<Content: UITableViewCell>: IdentifiableComponent, ActionComponent, SystemRowWrapper {
    public typealias Wrapped = SettingRow<Content>
    
    public var action: Action?
    
    public var wrapped: Wrapped
    
    public var id: String {
        wrapped.id + "\(accessoryType.rawValue)"
    }
    
    private var isGiven = false
    public var accessoryType: UITableViewCell.AccessoryType {
        get { isGiven ? wrapped.accessoryType : {
            switch (action, accessoryButtonAction) {
            case (nil, nil):      return .none
            case (.some, nil):    return .disclosureIndicator
            case (nil, .some):    return .detailButton
            case (.some, .some):  return .detailDisclosureButton
            }
        }()
        }
        set { wrapped.accessoryType = newValue; isGiven = true }
    }
    
    public var accessoryButtonAction: (() -> Void)?
    
    public init(_ text: String) {
        self.wrapped = Wrapped(text)
    }
    
    public func render(in content: Content) {
        wrapped.render(in: content)
        content.accessoryType = accessoryType
    }
    
    public func contentDidSelected(_ content: Content) {
        action?(content)
    }
}

extension NavigationRow {
    
    public func accessoryButtonAction(_ value: (() -> Void)?) -> Self {
        reform { $0.accessoryButtonAction = value }
    }
    
    public func accessoryType(_ value: UITableViewCell.AccessoryType) -> Self {
        reform { $0.accessoryType = value }
    }
    
    private func reform(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}
