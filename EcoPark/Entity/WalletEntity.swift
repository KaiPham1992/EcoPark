//
//  WalletEntity.swift
//  EcoPark
//
//  Created by Henry on 11/10/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper
class WalletEntity: BaseEntity {
    var wallet: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
    
        self.wallet <- map["wallet"]
    }
}
