//
//  WalletEntity.swift
//  EcoPark
//
//  Created by Henry on 11/10/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper
class WalletEntity: BaseEntity {
    var historyWallet: [HistoryWallet]?
    var wallet: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.historyWallet <- map["history_wallet"]
        self.wallet <- (map["wallet"], StringToIntTransform())
    }
}

class HistoryWallet: BaseEntity {
    var id: String?
    var account_id: String?
    var price: Double?
    var status: String?
    var content: String?
    var create_time_mi: Date?
    var is_active: Bool?
    var booking_id: String?
    var parking_id: String?
    var boss_id: String?
    
    override func mapping(map: Map) {
        self.id <- map["_id"]
        self.account_id <- map["account_id"]
        self.price <- (map["price"], StringToDoubleTransform())
        self.status <- map["status"]
        self.content <- map["description"]
        self.create_time_mi <- (map["create_time_mi"], AppTimestampTransform())
        self.is_active <- map["is_active"]
        self.booking_id <- map["booking_id"]
        self.parking_id <- map["parking_id"]
        self.boss_id <- map["boss_id"]
    }
}
