import UIKit
import SwiftUI
import Carbon

final class HomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    private let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        renderer.target = tableView

        renderer.render {
            Header("EXAMPLES")
                .identified(\.title)

            HomeItem(title: "👋 Hello") { [weak self] in
                self?.navigationController?.pushViewController(HelloViewController(), animated: true)
            }

            HomeItem(title: "🔠 Pangram") { [weak self] in
                self?.navigationController?.pushViewController(PangramViewController(), animated: true)
            }

            HomeItem(title: "⛩ Kyoto") { [weak self] in
                self?.navigationController?.pushViewController(KyotoViewController(), animated: true)
            }

            HomeItem(title: "😀 Shuffle Emoji") { [weak self] in
                self?.navigationController?.pushViewController(EmojiViewController(), animated: true)
            }

            HomeItem(title: "📋 Todo App") { [weak self] in
                self?.navigationController?.pushViewController(TodoViewController(), animated: true)
            }
            
            HomeItem(title: "👤 Profile Form") { [weak self] in
                self?.navigationController?.pushViewController(FormViewController(), animated: true)
            }

            HomeItem(title: "⛩ Kyoto SwiftUI") { [weak self] in
                if #available(iOS 13.0, *) {
                    let controller = HostingController(rootView: KyotoSwiftUIView())
                    self?.navigationController?.pushViewController(controller, animated: true)
                }
            }
            
            HomeItem(title: "👤 Jenga 1") { [weak self] in
                self?.navigationController?.pushViewController(JengaViewController(), animated: true)
            }
            
            HomeItem(title: "👤 Jenga 2") { [weak self] in
                self?.navigationController?.pushViewController(JengaViewController2(), animated: true)
            }
        }
    }
}
