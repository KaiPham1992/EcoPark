//
//  HistoryBookingParkingResponse.swift
//  EcoPark
//
//  Created by Steve on 11/10/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper


enum StatusBooking : String {
    case cancel, checked_out, checked_in, reservation, expired
}

class HistoryBookingParkingResponse : BaseEntity {
    
    var fullname: String?
    var img_src: String?
    var package_price: String?
    var price: String?
    var id: String?
    var account_id: String?
    var code: String?
    var vehicle_id: String?
    var license_plates: String?
    var intend_checkin_time: Date?
    var status: String?
    var parking_id: String?
    var is_active: String?
    var create_time: Date?
    var update_time: Date?
    var create_time_mi: Date?
    var intend_checkout_time: Date?
    var money_paid: Double?
    var parking_details: ParkingInfoEntity?
    var current_server_time: Int?
    var vehicle_name: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
    
        self.fullname <- map["fullname"]
        self.img_src <- map["img_src"]
        self.package_price <- map["package_price"]
        self.price <- map["price"]
        self.id <- map["_id"]
        self.account_id <- map["account_id"]
        self.code <- map["code"]
        self.vehicle_id <- map["vehicle_id"]
        self.license_plates <- map["license_plates"]
        self.intend_checkin_time <- (map["intend_checkin_time"], AppTimestampTransform())
        self.status <- map["status"]
        self.parking_id <- map["parking_id"]
        self.is_active <- map["is_active"]
        self.create_time <- (map["create_time"], yyyyMMddHHmmssTransform())
        self.update_time <- (map["update_time"], yyyyMMddHHmmssTransform())
        self.create_time_mi <- (map["create_time_mi"], yyyyMMddHHmmssTransform())
        self.intend_checkout_time <- (map["intend_checkout_time"], yyyyMMddHHmmssTransform())
        self.money_paid <- map["money_paid"]
        self.parking_details <- map["parking_details"]
        self.current_server_time <- map["current_server_time"]
        self.vehicle_name <- map["vehicle_name"]
    }
    
    var urlAvatar:  URL? {
        if let urlString = self.img_src, let url = URL(string: BASE_URL_IMAGE + urlString) {
            return url
            
        }
        
        return nil
    }
}
