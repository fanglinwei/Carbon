//
//  JengaViewController.swift
//  Example-iOS
//
//  Created by 方林威 on 2022/12/12.
//  Copyright © 2022 Ryo Aoyama. All rights reserved.
//

import UIKit
import Carbon

final class JengaViewController: UIViewController, DSLAutoTableCarbon {
    
    let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    private var name = "LEE"
    
    private var color = UIColor.red
    
    var header = "Header"
    var a = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        tableView.rowHeight = 44
        after()
    }
    
    @UnitBuilder
    var unit: [CarbonUnit] {
        
        Header("EXAMPLES1" + header)
            .identified(by: \.title)
        
        JengaActionItem(title: "JengaActionItem 1")
            .onTap(on: self) { (self) in
                print(self, 1)
            }
            .identified(by: \.title)
        
        JengaActionItem(title: "JengaActionItem 2")
            .onTap(on: self) { (self) in
                print(self, 2)
            }

        JengaActionItem(title: "JengaActionItem 3")
            .onTap(on: self) { (self) in
                print(self, 3)
            }
            .height(100)

        WrapperComponent<LabelView>(name)
            .onTap({ view, data in
                print(view, data)
            })
            .identified()

        WrapperComponent(name) {
            LabelView()
        }
        .identified(by: "123")
        .with(\.backgroundColor, .green)
        .height(100)

        WrapperComponent<ColorView>(color)
            .onTap { (view, data) in
                print(view, data)
            }
            .identified(by: "123")
            .with(\.backgroundColor, .green)
            .height(100)
            .update { content in
                    
            }

        Spacing(100)
            .identified()

        Section(id: "123") {
            Header("Section")
                .identified(by: \.title)

            JengaActionItem(title: "Section item 1")
                .onTap(on: self) { (self) in
                    print(self, 1)
                }
                .with(\.backgroundColor, .green)
        }
    }
    
    func after() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.setState {
                self.color = .blue
                self.name = "DAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGEDAGE"
                self.a = false
                self.header = "footer"
            }
        }
    }
}

class ColorView: UIView, WrapperComponentable {
    
    func configure(with data: UIColor) {
        backgroundColor = data
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LabelView: UIView, WrapperComponentable {
    
    lazy var label = UILabel()
    
    func configure(with data: String) {
        label.text = data
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.numberOfLines = 0
        label.textColor = .black
        addSubview(label)
        
        label.fillToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UIView {

    func fillToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
}
