//
//  HistoryWalletEntity.swift
//  EcoPark
//
//  Created by Henry on 11/10/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper
class HistoryWalletEntity: BaseEntity {
    
    var id: String?
    var account_id: String?
    var price: Double?
    var status: String?
    var content: String?
    var create_time_mi: Date?
    var is_active: Bool?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
    
        self.id <- map["_id"]
        self.account_id <- map["account_id"]
        self.price <- (map["price"], StringToDoubleTransform())
        self.status <- map["status"]
        self.content <- map["description"]
        self.create_time_mi <- (map["create_time_mi"], AppTimestampTransform())
        self.is_active <- map["is_active"]
    }
}

