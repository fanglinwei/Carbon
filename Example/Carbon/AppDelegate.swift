import UIKit
import Carbon

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        JengaEnvironment.setup(JengaProvider())
        
        if #available(iOS 13.0, *) {
            configureUIAppearance()
        } 

        let window = UIWindow()
        window.rootViewController = UINavigationController(rootViewController: HomeViewController())
        window.makeKeyAndVisible()
        self.window = window

        return true
    }

    @available(iOS 13.0, *)
    func configureUIAppearance() {
        let appearance = UINavigationBar.appearance()
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label
        ]

        appearance.tintColor = .label
        appearance.prefersLargeTitles = true
        appearance.isTranslucent = true
        appearance.titleTextAttributes = titleTextAttributes
        appearance.largeTitleTextAttributes = titleTextAttributes
    }
}

struct JengaProvider: Carbon.JengaProvider {
    
    func defaultTableView(with frame: CGRect) -> UITableView {
        let tableView: UITableView
        if #available(iOS 13.0, *) {
            // https://github.com/JarhomChen/TableViewOfInsetGrouped
            tableView = UITableView(frame: frame, style: .insetGrouped)
        } else {
            tableView = UITableView(frame: frame, style: .grouped)
        }
        return tableView
    }
}
