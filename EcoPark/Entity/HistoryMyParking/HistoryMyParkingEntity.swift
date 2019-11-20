//
//  HistoryMyParkingEntity.swift
//  EcoPark
//
//  Created by Tu DV on 11/20/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper

class HistoryMyParkingEntity: BaseEntity {
    
    var name: String?
    var address: String?
    var time_start: String?
    var time_end: String?
    var lat: String?
    var long: String?
    var phone: String?
    var price: String?
    var package_price: String?
    var package_number: String?
    var fullname: String?
    var number_place: String?
    var parked_number: String?
    var reservation_number: Int?
    var current_server_time: Date?
    var booking: [BookingEntity] = []
    
    override func mapping(map: Map) {
        
        self.name <- map["name"]
        self.address <- map["address"]
        self.time_start <- map["time_start"]
        self.time_end <- map["time_end"]
        self.lat <- map["lat"]
        self.long <- map["long"]
        self.phone <- map["phone"]
        self.price <- map["price"]
        self.package_price <- map["package_price"]
        self.package_number <- map["package_number"]
        self.fullname <- map["fullname"]
        self.number_place <- map["number_place"]
        self.parked_number <- map["parked_number"]
        self.current_server_time <- (map["current_server_time"], yyyyMMddHHmmssTransform())
        self.booking <- map["booking"]
        self.reservation_number <- map["reservation_number"]
    }
}
