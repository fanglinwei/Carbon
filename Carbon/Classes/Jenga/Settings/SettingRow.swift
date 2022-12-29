//
//  SettingRow.swift
//  Carbon
//
//  Created by 方林威 on 2022/12/27.
//  Copyright © 2022 Ryo Aoyama. All rights reserved.
//

import UIKit

public struct SettingRow<Content: UITableViewCell>: IdentifiableComponent, SystemRow {
    
    public var text: TextValues
    
    public var detailText: TextValues = .none
    
    public var icon: Icon?
    
    public var cellStyle: UITableViewCell.CellStyle = .default
    
    public var accessoryType: UITableViewCell.AccessoryType = .none
    
    public var selectionStyle: UITableViewCell.SelectionStyle = .blue
    
    public var id: String {
        "\(text.hashValue)" +
        "\(detailText.hashValue)" +
        (icon.flatMap { "\($0.hashValue)"} ?? "")
    }
    
    
    public init(_ text: String) {
        self.text = .init(string: text)
    }
    
    public func renderContent() -> Content {
        Content(style: cellStyle, reuseIdentifier: nil)
    }

    public func render(in content: Content) {
        reset(content)
        binding(with: content)
    }
}

extension SettingRow {
    
    private func binding(with content: Content) {
        // 标题
        text.perform(content.textLabel)
        
        // 子标题
        switch self.cellStyle {
        case .default:
            content.detailTextLabel?.text = nil
            
        case .subtitle, .value1, .value2:
            detailText.perform(content.detailTextLabel)
        @unknown default:
            break
        }
        
        // 关联图片
        switch icon {
        case .image(let value):
            value.loadImage(with: content.imageView) { [weak content] result in
                guard result else { return }
                // https://www.cnblogs.com/lisa090818/p/3508390.html
                content?.setNeedsLayout()
            }
            
        case .async(let value):
            value.loadImage(with: content.imageView) { [weak content] result in
                guard result else { return }
                // https://www.cnblogs.com/lisa090818/p/3508390.html
                content?.setNeedsLayout()
            }
        case .none:
            content.imageView?.image = nil
        }
        
        content.accessoryView = nil
    }
    
    private func reset(_ content: Content) {
        content.textLabel?.text = nil
        content.textLabel?.attributedText = nil
        content.detailTextLabel?.text = nil
        content.detailTextLabel?.attributedText = nil
        content.imageView?.image = nil
        content.imageView?.highlightedImage = nil
    }
}

open class SettingContent: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup() {
        contentView.backgroundColor = .white
        backgroundColor = .white
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
