//
//  JengaActionItem.swift
//  Example-iOS
//
//  Created by 方林威 on 2022/12/12.
//  Copyright © 2022 Ryo Aoyama. All rights reserved.
//

import UIKit
import Carbon

struct JengaActionItem: IdentifiableComponent, CarbonUnit {
    
    var title: String
    
    var id: String {
        title
    }

    func renderContent() -> JengaItemContent {
        JengaItemContent()
    }

    func render(in content: JengaItemContent) {
        content.titleLabel.text = title
    }
}

class JengaItemContent: UIView {
    
    lazy var titleLabel: UILabel = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.textColor = .black
//        titleLabel.frame = CGRect.init(x: 0, y: 0, width: 100, height: 20)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

