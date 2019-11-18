//
//  ParkingDetailEntity.swift
//  EcoPark
//
//  Created by Steve on 11/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class ParkingDetailEntity : Mappable {
    var name : String?
    var address : String?
    var time_start : String?
    var time_end : String?
    var lat : String?
    var long : String?
    var phone : String?
    var price : String?
    var package_price : String?
    var package_number : String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
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
    }
}
