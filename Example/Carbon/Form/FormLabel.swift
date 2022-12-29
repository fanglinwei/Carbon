import UIKit
import Carbon

struct FormLabel: IdentifiableComponent {
    var title: String
    var text: String?
    var onSelect: () -> Void

    var id: String {
        title
    }

    func renderContent() -> FormLabelContent {
        .loadFromNib()
    }

    func render(in content: FormLabelContent) {
        content.titleLabel.text = title
        content.textLabel.text = text
        content.onSelect = onSelect
    }
}

final class FormLabelContent: UIControl, NibLoadable {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textLabel: UILabel!

    var onSelect: (() -> Void)?

    override var isHighlighted: Bool {
        didSet {
            if #available(iOS 13.0, *) {
                backgroundColor = isHighlighted ? .systemGray4 : .secondarySystemBackground
            } else {
                backgroundColor = .darkText
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        addTarget(self, action: #selector(selected), for: .touchUpInside)
    }

    @objc func selected() {
        onSelect?()
    }
}
