//
//  BookingDetailEntity.swift
//  EcoPark
//
//  Created by Henry on 11/8/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper
class BookingDetailEntity: BaseEntity {
    
    var id: String?
    var account_id: String?
    var code: String?
    var vehicle_id: String?
    var license_plates: String?
    var intend_checkin_time: String?
    var status: String?
    var parking_id: String?
    var is_active: String?
    var create_time: String?
    var update_time: String?
    var create_time_mi: String?
    var intend_checkout_time: String?
    var money_paid: String?
    var parking_details: ParkingInfoEntity?
    var current_server_time: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
    
        self.id <- map["_id"]
        self.account_id <- map["account_id"]
        self.code <- map["code"]
        self.vehicle_id <- map["vehicle_id"]
        self.license_plates <- map["license_plates"]
        self.intend_checkin_time <- map["intend_checkin_time"]
        self.status <- map["status"]
        self.parking_id <- map["parking_id"]
        self.is_active <- map["is_active"]
        self.create_time <- map["create_time"]
        self.update_time <- map["update_time"]
        self.create_time_mi <- map["create_time_mi"]
        self.intend_checkout_time <- map["intend_checkout_time"]
        self.money_paid <- map["money_paid"]
        self.parking_details <- map["parking_details"]
        self.current_server_time <- map["current_server_time"]
        
    }
}


