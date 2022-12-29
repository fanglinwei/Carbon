import UIKit

public struct Footer: Component, CarbonUnit {
    
    public var text: String

    public init(_ text: String) {
        self.text = text
    }

    public func renderContent() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }

    public func render(in content: UILabel) {
        content.text = text
    }
}
