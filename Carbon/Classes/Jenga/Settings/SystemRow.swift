//
//  SystemRow.swift
//  Carbon
//
//  Created by 方林威 on 2022/12/27.
//  Copyright © 2022 Ryo Aoyama. All rights reserved.
//

import UIKit
/// 系统样式
public protocol SystemRow: CarbonUnit {
    
    /// The text of the row.
    var text: TextValues { get set }
    /// The detail text of the row.
    var detailText: TextValues { get set }
    
    /// The icon of the row.
    var icon: Icon? { get set }
    
    /// The type of standard accessory view the cell should use.
    var accessoryType: UITableViewCell.AccessoryType { get set }

    var selectionStyle: UITableViewCell.SelectionStyle { get set }
    
    /// The style of the table view cell to display the row.
    var cellStyle: UITableViewCell.CellStyle { get set }
}

public extension SystemRow {
    
    func icon(_ value: Icon) -> Self {
        reform { $0.icon = value }
    }
    
    func detailText(_ value: String) -> Self {
        reform {
            $0.detailText = detailText.with(\.string, value)
        }
    }
    
    func detailText(_ value: DetailText) -> Self {
        reform {
            $0.detailText = value.text
            $0.cellStyle = value.cellStyle
        }
    }
    
    func text<Value>(_ keyPath: WritableKeyPath<TextValues, Value>, _ value: Value) -> Self {
        reform { $0.text = text.with(keyPath, value) }
    }
    
    func detailText<Value>(_ keyPath: WritableKeyPath<TextValues, Value>, _ value: Value) -> Self {
        reform { $0.detailText = detailText.with(keyPath, value) }
    }
    
    func cellStyle(_ value: UITableViewCell.CellStyle) -> Self {
        reform {
            $0.cellStyle = value
        }
    }
    
    func selectionStyle(_ value: UITableViewCell.SelectionStyle) -> Self {
        reform { $0.selectionStyle = value }
    }
    
    private func reform(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}

public protocol SystemRowWrapper: SystemRow, ComponentWrapping where Wrapped: SystemRow {
    
    var wrapped: Wrapped { get set }
}

public extension SystemRowWrapper {
    
    /// The text of the row.
    var text: TextValues {
        get { wrapped.text }
        set { wrapped.text = newValue }
    }
    /// The detail text of the row.
    var detailText: TextValues {
        get { wrapped.detailText }
        set { wrapped.detailText = newValue }
    }
    
    /// The icon of the row.
    var icon: Icon? {
        get { wrapped.icon }
        set { wrapped.icon = newValue }
    }
    
    /// The style of the table view cell to display the row.
    var cellStyle: UITableViewCell.CellStyle {
        get { wrapped.cellStyle }
        set { wrapped.cellStyle = newValue }
    }
    
    /// The type of standard accessory view the cell should use.
    var accessoryType: UITableViewCell.AccessoryType {
        get { wrapped.accessoryType }
        set { wrapped.accessoryType = newValue }
    }
    
    var selectionStyle: UITableViewCell.SelectionStyle {
        get { wrapped.selectionStyle }
        set { wrapped.selectionStyle = newValue }
    }
}

public enum ComponentSize {
    case constant(CGFloat)
    case size(CGSize)
    case automaticDimension
}
