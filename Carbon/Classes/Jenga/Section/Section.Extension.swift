import UIKit

public extension Section {
    
    func header<H: Component>(_ value: @autoclosure () -> (H)) -> Self {
        reform { $0.header = ViewNode(value()) }
    }
    
    func header(_ value: @autoclosure () -> (ViewNode)) -> Self {
        reform { $0.header = value() }
    }

    func header(_ value: @autoclosure () -> (String)) -> Self {
        reform { $0.header = ViewNode(Header(value())) }
    }
    
    func footer<F: Component>(_ value: @autoclosure () -> (F)) -> Self {
        reform { $0.footer = ViewNode(value()) }
    }
    
    func footer(_ value: @autoclosure () -> (ViewNode)) -> Self {
        reform { $0.footer = value() }
    }

    func footer(_ value: @autoclosure () -> (String)) -> Self {
        reform { $0.footer = ViewNode(Footer(value())) }
    }
    
    func headerHeight(_ value: @autoclosure () -> (CGFloat)) -> Self {
        var copy = self

        if let header = copy.header {
            copy.header = ViewNode(header.component.height(value()))
        } else {
            copy.header = ViewNode(Spacing(value()))
        }
        return copy
    }

    func footerHeight(_ value: @autoclosure () -> (CGFloat)) -> Self {
        var copy = self

        if let footer = copy.footer {
            copy.footer = ViewNode(footer.component.height(value()))
        } else {
            copy.footer = ViewNode(Spacing(value()))
        }
        return copy
    }
    
    private func reform(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}
