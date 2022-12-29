//
//  TapActionRow.swift
//  Carbon
//
//  Created by 方林威 on 2022/12/27.
//  Copyright © 2022 Ryo Aoyama. All rights reserved.
//

import UIKit

public struct TapActionRow<Content: TapActionContent>: IdentifiableComponent, ActionComponent, SystemRowWrapper {
    public typealias Wrapped = SettingRow<Content>
    
    public var action: Action?
    
    public var id: String {
        wrapped.id
    }
    
    public var wrapped: Wrapped
    
    public var textAlignment: NSTextAlignment = .center
    
    private var disabled = Wrapper(false)
    
    public init(_ text: String) {
        self.wrapped = Wrapped(text)
    }
    
    public func render(in content: Content) {
        wrapped.render(in: content)
        content.textLabel?.textAlignment = textAlignment
        content.textLabel?.textColor = wrapped.text.color ?? content.tintColor
    }
    
    public func contentDidSelected(_ content: Content) {
        guard !disabled.value else { return }
        action?(content)
    }
}

public extension TapActionRow {
    
    func textAlignment(_ value: NSTextAlignment) -> Self {
        reform { $0.textAlignment = value }
    }
    
    func disabled(_ value: Bool) -> Self {
        reform { $0.disabled.value = value }
    }
    
    private func reform(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}

open class TapActionContent: UITableViewCell {

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpAppearance()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpAppearance()
    }
    
    private func setUpAppearance() {
        textLabel?.numberOfLines = 0
        textLabel?.textAlignment = .center
    }
}


@dynamicMemberLookup
class Wrapper<T> {
    var value : T
    init(_ value: T) { self.value = value }
    
    subscript<U>(dynamicMember member: KeyPath<T, U>) -> U {
        value[keyPath: member]
    }
}
