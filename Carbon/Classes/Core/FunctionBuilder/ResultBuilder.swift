import Foundation

@resultBuilder
public struct ArrayBuilder<Component> {
    
    public typealias ContentBlock = () -> [Component]
}

public extension ArrayBuilder {
    
    /// 组合全部表达式的返回值
    static func buildBlock(_ component: [Component]...) -> [Component] {
        component.flatMap { $0 }
    }
    
    static func buildIf(_ component: [Component]?...) -> [Component] {
        component.flatMap { $0 ?? [] }
    }
    
    /// 处理空白block
    static func buildOptional<T>(_ component: [T]?) -> [Component] {
        []
    }
    
    /// 处理不包含else的if语句
    static func buildOptional(_ component: [Component]?) -> [Component] {
        component ?? []
    }
    
    /// 处理每一行表达式的返回值
    static func buildExpression(_ expression: Component) -> [Component] {
        [expression]
    }
    
    static func buildExpression(_ expression: Component?) -> [Component] {
        expression.flatMap { [$0] } ?? []
    }
    
    static func buildExpression(_ expression: Void) -> [Component] {
        []
    }
    
    static func buildExpression(_ expression: Void?) -> [Component] {
        []
    }
    
    static func buildExpression(_ expression: [Component]) -> [Component] {
        expression
    }
    
    /// 处理for循环
    static func buildArray(_ components: [[Component]]) -> [Component] {
        components.flatMap { $0 }
    }
    
    /// 处理if...else...（必须包含else)
    static func buildEither(first: [Component]) -> [Component] {
        first
    }
    
    static func buildEither(second: [Component]) -> [Component] {
        second
    }
    
    static func buildLimitedAvailability(_ component: [Component]) -> [Component] {
        component
    }
}
