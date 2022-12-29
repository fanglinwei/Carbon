import SwiftUI

public struct Header: Component, View , CarbonUnit {
    
    public var title: String

    public init(_ title: String) {
        self.title = title
    }

    public func renderContent() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }

    public func render(in content: UILabel) {
        content.text = title
    }
}
