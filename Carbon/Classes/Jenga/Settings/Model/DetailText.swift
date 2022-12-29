import UIKit

/// An enum that represents a detail text with `UITableViewCell.CellStyle`.
public struct DetailText: Equatable {
    
    public var cellStyle: UITableViewCell.CellStyle = .default
    public var text: TextValues = .init()
    
    public init() { }
}

public extension DetailText {
    
    static var `default`: DetailText { .init() }
    
    static func subtitle(_ value: String) -> DetailText {
        return .init(.subtitle, value)
    }
    
    static func value1(_ value: String) -> DetailText {
        return .init(.value1, value)
    }
    
    static func value2(_ value: String) -> DetailText {
        return .init(.value2, value)
    }
    
    private init(_ cellStyle: UITableViewCell.CellStyle, _ string: String?) {
        self.cellStyle = cellStyle
        self.text.string = string
    }
}
