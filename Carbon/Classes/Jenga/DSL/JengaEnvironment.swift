import UIKit

public enum JengaEnvironment { }

extension JengaEnvironment {
    
    internal static var provider: JengaProvider = Provider()
    
    public static var isEnabledLog: Bool = true
    
    public static func setup(_ provider: JengaProvider?) {
        UIViewController.swizzled
        guard let provider = provider else { return }
        self.provider = provider
    }
}

public protocol JengaProvider {
    
    func defaultTableView(with frame: CGRect) -> UITableView
}

public extension JengaProvider {
    
    func defaultTableView(with frame: CGRect) -> UITableView {
        let tableView: UITableView
        if #available(iOS 13.0, *) {
            tableView = UITableView(frame: frame, style: .insetGrouped)
        } else {
            tableView = UITableView(frame: frame, style: .grouped)
        }
        return tableView
    }
}


internal extension JengaEnvironment {
    
    struct Provider: JengaProvider {
        
    }
}
