import UIKit

public protocol DSLCarbon {
    
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
}
