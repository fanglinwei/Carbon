import UIKit

public protocol DSLCarbon: AnyObject {
    
    associatedtype U: Updater
    
    var renderer: Renderer<U> { get }
    
    @UnitBuilder var unit: [CarbonUnit] { get }
    
    func render()
}

public extension DSLCarbon {
    
    func render() {
        renderer.render(unit)
    }
    
    func setState(_ context: () -> Void) {
        context()
        render()
    }
    
    func bindPropertys() {
        let mirror = Mirror(reflecting: self)
        guard !mirror.children.isEmpty else { return }
        for child in mirror.children {
            if let property = child.value as? (PropertyReload) {
                property.update {
                    DispatchQueue.main.async {
                        self.render()
                    }
                }
            }
        }
    }
}
