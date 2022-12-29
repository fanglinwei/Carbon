import UIKit

public struct ToggleRow<Content: ToggleContent>: IdentifiableComponent, SystemRowWrapper {
    
    public typealias Wrapped = SettingRow<Content>
        
    public var id: String {
        wrapped.id + isOn.wrappedValue.description
    }

    public var wrapped: Wrapped
    
    public var isOn: Binding<Bool>
    
    private var onTap: ((Bool) -> Void)?
    
    public init(_ text: String, isOn: Binding<Bool>) {
        self.isOn = isOn
        self.wrapped = Wrapped(text)
    }
    
    public func render(in content: Content) {
        wrapped.render(in: content)
        content.accessoryView = content.switchControl
        binding(with: content)
    }
    
    public func contentDidEndDisplay(_ content: Content) {
        wrapped.contentDidEndDisplay(content)
        recovery(in: content)
    }
    
    private let _observer = _Observer()
    private class _Observer { }
}

extension ToggleRow {
    
    private func binding(with content: Content) {
        content.switchControl.binding.isOn(binding: isOn) { isOn in
            onTap?(isOn)
        }
    }
    
    private func recovery(in content: Content) {
        isOn.remove(observer: _observer)
    }
}

public extension ToggleRow {
    
    func isOn(_ value: Bool) -> Self {
        reform { $0.isOn = .constant(value) }
    }
    
    /// Toggle click
    func onTap(_ value: @escaping (Bool) -> Void) -> Self {
        reform { $0.onTap = value }
    }
    
    func onTap<S>(on target: S, _ value: @escaping (S, Bool) -> Void) -> Self where S: AnyObject {
        onTap { [weak target] (isOn: Bool) in
            guard let target = target else { return }
            value(target, isOn)
        }
    }
    
    private func reform(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}

open class ToggleContent: UITableViewCell {

    public private(set) lazy var switchControl = UISwitch()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpAppearance()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpAppearance()
    }
    
    private func setUpAppearance() {
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
    }
}
