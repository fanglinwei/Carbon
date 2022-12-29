import UIKit

public struct Spacing: Component {
    
    var height: CGFloat

    var color: UIColor
    
    public init(_ height: CGFloat = 10, color: UIColor = .clear) {
        self.height = height
        self.color = color
    }

    public func renderContent() -> UIView {
        UIView()
    }

    public func render(in content: UIView) {
        content.backgroundColor = color
    }

    public func referenceSize(in bounds: CGRect) -> CGSize? {
        CGSize(width: bounds.width, height: height)
    }
}

extension Spacing {
    
    func color(_ color: UIColor) -> Self {
        reform { $0.color = color }
    }
    
    private func reform(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}

