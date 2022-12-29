import SwiftUI
import Carbon

struct KyotoLicense: Component, View {
    var onSelected: () -> Void

    func renderContent() -> KyotoLicenseContent {
        .loadFromNib()
    }

    func render(in content: KyotoLicenseContent) {
        content.onSelected = onSelected
    }

    func referenceSize(in bounds: CGRect) -> CGSize? {
        CGSize(width: bounds.size.width, height: 71)
    }
}

final class KyotoLicenseContent: UIControl, NibLoadable {
    override var isHighlighted: Bool {
        didSet {
            if #available(iOS 13.0, *) {
                backgroundColor = isHighlighted ? .systemGray4 : .clear
            } else {
                backgroundColor = .clear
            }
        }
    }

    var onSelected: (() -> Void)?

    override func awakeFromNib() {
         super.awakeFromNib()

        addTarget(self, action: #selector(selected), for: .touchUpInside)
    }

    @objc func selected() {
        onSelected?()
    }
}
