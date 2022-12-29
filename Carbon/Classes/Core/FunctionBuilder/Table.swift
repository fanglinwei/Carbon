//
//  Table.swift
//  Carbon
//
//  Created by 方林威 on 2022/12/13.
//  Copyright © 2022 Ryo Aoyama. All rights reserved.
//

public protocol CarbonUnit { }
extension Section: CarbonUnit {}
extension Group: CarbonUnit {}

struct UniqueIdentifier: Hashable {}

public typealias UnitBuilder = ArrayBuilder<CarbonUnit>
