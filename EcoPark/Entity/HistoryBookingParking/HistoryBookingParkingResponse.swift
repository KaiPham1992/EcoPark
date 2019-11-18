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

class HistoryBookingParkingResponse : Mappable {
    
    var _id : String?
    var account_id : String?
    var code : String?
    var qr_code : String?
    var vehicle_id : String?
    var license_plates : String?
    var intend_checkin_time : String?
    var status : String?
    var parking_id : String?
    var is_active : String?
    var create_time : String?
    var update_time : String?
    var create_time_mi : String?
    var time_check_in : String?
    var time_check_in_mi : String?
    var intend_checkout_time : String?
    var money_paid : String?
    var rating : String?
    var parking_details : ParkingDetailEntity?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.account_id <- map["account_id"]
        self.code <- map["code"]
        self.qr_code <- map["qr_code"]
        self.vehicle_id <- map["vehicle_id"]
        self.license_plates <- map["license_plates"]
        self.intend_checkin_time <- map["intend_checkin_time"]
        self.status <- map["status"]
        self.parking_id <- map["parking_id"]
        self.is_active <- map["is_active"]
        self.create_time <- map["create_time"]
        self.update_time <- map["update_time"]
        self.create_time_mi <- map["create_time_mi"]
        self.time_check_in <- map["time_check_in"]
        self.time_check_in_mi <- map["time_check_in_mi"]
        self.intend_checkout_time <- map["intend_checkout_time"]
        self.money_paid <- map["money_paid"]
        self.rating <- map["rating"]
        self.parking_details <- map["parking_details"]
    }
}
