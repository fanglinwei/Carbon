import UIKit
import Carbon

public struct NavigationBadgeRow<Content: NavigationBadgeContent>: IdentifiableComponent, SystemRowWrapper, ActionComponent {
    public typealias Wrapped = NavigationRow<Content>
    
    public var action: Action? {
        get { wrapped.action }
        set { wrapped.action = newValue }
    }
    
    public var wrapped: Wrapped
    
    public var id: String {
        wrapped.id + badgeColor.description + (badgeValue ?? "none")
    }
    
    private var badgeValue: String?
    private var badgeColor: UIColor = .red
    
    public init(_ text: String) {
        self.wrapped = Wrapped(text)
    }
    
    public func render(in content: Content) {
        wrapped.render(in: content)
        binding(with: content)
    }
}

extension NavigationBadgeRow {
    
    private func binding(with content: Content) {
        content.set(badgeValue: badgeValue)
        content.set(badgeColor: badgeColor)
    }
}

extension NavigationBadgeRow {
    
    public func accessoryButtonAction(_ value: (() -> Void)?) -> Self {
        reform { $0.wrapped.accessoryButtonAction = value }
    }
    
    public func accessoryType(_ value: UITableViewCell.AccessoryType) -> Self {
        reform { $0.wrapped.accessoryType = value }
    }
    
    func badgeValue(_ value: Bool) -> Self {
        reform {
            $0.badgeValue = value ? "" : nil
        }
    }
    
    func badgeValue(_ value: String?) -> Self {
        reform {
            $0.badgeValue = value
        }
    }
    
    func badgeColor(_ value: UIColor) -> Self {
        reform {
            $0.badgeColor = value
        }
    }
    
    private func reform(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}
