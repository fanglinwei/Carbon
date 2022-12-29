import UIKit

// 快速列表使用此协议, 协议都有默认实现 controller 只需要实现tableContents即可
public protocol DSLAutoTableCarbon: DSLCarbon {
    
    var tableView: UITableView { get }
    
    func didLayoutTable()
}

public extension DSLAutoTableCarbon {
    
    func reloadTableHeight(_ animated: Bool = false) {
        CATransaction.begin()
        if !animated {
            CATransaction.setDisableActions(true)
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        CATransaction.commit()
    }
}

private var TableViewKey: Void?
private var TableKey: Void?
public extension DSLAutoTableCarbon where Self: UIViewController {
    
    var tableView: UITableView {
        get {
            guard let value: UITableView = get(&TableViewKey) else {
                let temp = JengaEnvironment.provider.defaultTableView(with: .zero)
                set(retain: &TableViewKey, temp)
                return temp
            }
            return value
        }
        set { set(retain: &TableViewKey, newValue) }
    }
    
    func didLayoutTable() {
        renderer.target = tableView as? U.Target
        view.addSubview(tableView)
        tableView.fillToSuperview()
    }
}

extension UIViewController {
    
    static let swizzled: Void = {
        do {
            let originalSelector = #selector(UIViewController.viewDidLoad)
            let swizzledSelector = #selector(UIViewController.jenga_viewDidLoad)
            swizzled_method(originalSelector, swizzledSelector)
        }
    } ()
    
    @objc
    private func jenga_viewDidLoad() {
        jenga_viewDidLoad()
        
        (self as? (any DSLAutoTableCarbon))?.didLayoutTable()
        (self as? (any DSLAutoTableCarbon))?.render()
    }
}

extension UIView {

    func fillToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
}
