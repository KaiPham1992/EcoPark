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
    var payment_wallet: Double?
    var plus_wallet_boss: Double?
    var receivables: Double?
    var parking_details: ParkingInfoEntity?
    var current_server_time: Date?
    var vehicle_name: String?
    var payment: Double?
    var real_money: Double?
    var bonus: Double?
    var customer_payment_wallet: Double?
    var qrCode: String?
    var bookingID: String?
    
    var time_check_out: Date?
    var time_check_in: Date?
    
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
        self.update_time <- (map["update_time"], AppTimestampTransform())
        self.create_time_mi <- (map["create_time_mi"], AppTimestampTransform())
        
        self.time_check_in <- (map["time_check_in_mi"], AppTimestampTransform())
        self.time_check_out <- (map["time_check_out_mi"], AppTimestampTransform())
        
        self.intend_checkout_time <- (map["intend_checkout_time"], AppTimestampTransform())
        self.money_paid <- (map["money_paid"], StringToDoubleTransform())
        self.parking_details <- map["parking_details"]
        self.current_server_time <- (map["current_server_time"], AppTimestampTransform())
        self.vehicle_name <- map["vehicle_name"]
        self.payment <- map["payment"]
        self.real_money <- map["real_money"]
        self.bonus <- map["bonus"]
        self.customer_payment_wallet <- map["customer_payment_wallet"]
        self.plus_wallet_boss <- map["plus_wallet_boss"]
        self.qrCode <- map["qr_code"]
        self.bookingID <- map["booking_id"]
    }
    
    var urlQRCode:  URL? {
        if let urlString = self.qrCode, let url = URL(string: BASE_URL_IMAGE + urlString) {
            return url
            
        }
        
        return nil
    }
    
    var urlAvatar:  URL? {
        if let urlString = self.img_src, let url = URL(string: BASE_URL_IMAGE + urlString) {
            return url
            
        }
        
        return nil
    }
}
