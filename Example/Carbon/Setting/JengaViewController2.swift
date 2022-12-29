//
//  JengaViewController2.swift
//  Example-iOS
//
//  Created by 方林威 on 2022/12/27.
//  Copyright © 2022 Ryo Aoyama. All rights reserved.
//

import UIKit
import Carbon

final class JengaViewController2: UIViewController, DSLAutoTableCarbon {
    
    let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    private var row1 = "NavigationRow 1"
    
    private var row10 = "NavigationRow 10"
    
    private var detail1 = "NavigationRow Detail 1"
    
    @State private var isTap = false
    
    private var isRed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        tableView.rowHeight = 44
        renderer.updater.reloadRowsAnimation = .none
        after()
    }
    
    @UnitBuilder
    var unit: [CarbonUnit] {
        
        Section(id: "Settings") {
            
            NavigationRow(row10)
                .detailText("detailText")
                .cellStyle(.value1)
                .onTap(on: self) { (self) in
                    print(self, 1)
                }
                .height(100)
            
            TapActionRow("点击了")
                .disabled(isTap)
                .textAlignment(.left)
                .onTap {
                    print("点击率")
                }
                .update({ content in
                    content.backgroundColor = .white
                })
            
            ToggleRow("开关", isOn: $isTap)
                .onTap { isOn in
                    print(isOn)
                }
                .height(100)
                .identified(by: "开关")
            
            
            NavigationBadgeRow("NavigationRow")
                .badgeValue(isRed)
                .icon(.image(UIImage(named: "Trash")))
                .detailText("detailText")
                .cellStyle(.value1)
                .onTap(on: self) { (self) in
                    print(self, 1)
                }
            
            NavigationRow("NavigationRow")
                .detailText("detailText")
                .cellStyle(.value1)
                .height(100)
                .onTap(on: self) { (self) in
                    print(self, 1)
                }
                .with(\.backgroundColor, .red)
                .height(200)
            
            NavigationRow("NavigationRow")
                .accessoryType(.disclosureIndicator)
                .detailText("detailText")
                .cellStyle(.subtitle)
                .onTap(on: self) { (self) in
                    print(self, 1)
                }
            
            NavigationRow("NavigationRow")
                .accessoryType(.disclosureIndicator)
                .detailText("detailText")
                .cellStyle(.value1)
                .onTap(on: self) { (self) in
                    print(self, 1)
                }
            
            NavigationRow("NavigationRow")
                .accessoryType(.disclosureIndicator)
                .detailText("detailText")
                .cellStyle(.value1)
                .onTap(on: self) { (self) in
                    print(self, 1)
                }
            
            NavigationRow("NavigationRow")
                .accessoryType(.disclosureIndicator)
                .detailText("detailText")
                .cellStyle(.value1)
                .onTap(on: self) { (self) in
                    print(self, 1)
                }
            
            NavigationRow("NavigationRow")
                .accessoryType(.disclosureIndicator)
                .detailText("detailText")
                .cellStyle(.value1)
                .onTap(on: self) { (self) in
                    print(self, 1)
                }
        }
        .header(Header("Settings"))
        .headerHeight(100)
        .footer("footer")
        .footerHeight(100)
    }
    
    func after() {
        func r() {
            setState {
                row1 = "NavigationRow 1111"
                detail1 = "NavigationRow Detail 111"
                row10 = "NavigationRow 10101010"
                isTap = true
                isRed = false
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            r()
        }
    }
}
