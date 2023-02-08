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
    
    @State private var row10 = "NavigationRow 9999"
    
    @State private var detail1 = "NavigationRow Detail 1"
    
    @State private var isTap = false
    
    @State private var isRed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        tableView.rowHeight = 44
        renderer.updater.reloadRowsAnimation = .none
    }
    
    @UnitBuilder
    var unit: [CarbonUnit] {
        
        Section(id: "Settings") {
            
            NavigationRow(row10)
                .detailText("detailText")
                .cellStyle(.value1)
                .onTap(on: self) { (self) in
                    self.row10 = "NavigationRow" + "\(Int.random(in: 1000 ..< 9999))"
                    self.detail1 = "NavigationRow Detail 111"
                    self.isTap = true
                    self.isRed = false
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
                .identified("开关")
            
            
            NavigationBadgeRow("NavigationRow")
                .badgeValue(isRed)
                .icon(.image(UIImage(named: "Trash")))
                .detailText("detailText")
                .cellStyle(.value1)
                .onTap(on: self) { (self) in
                    print(self, 1)
                }
                .identified("NavigationRow Badge")
            
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
}
