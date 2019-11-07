//
//  ParkingInfoEntity.swift
//  EcoPark
//
//  Created by Henry on 11/6/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper

class ParkingInfoEntity: BaseEntity {
    var id: String?
    var code_tax: String?
    var name: String?
    var type_id: String?
    var address: String?
    var price: Double?
    var package_price: Double?
    var package_number: String?
    var number_place: String?
    var ordinal: String?
    var is_active: Bool?
    var create_time: Date?
    var time_start: Date?
    var time_end: Date?
    var lat: Double?
    var long: Double?
    var rating: Double?
    var account_id: String?
    var parking_type: String?
    var fullname: String?
    var identity_number: String?
    var issued_date: Date?
    var issued_by: String?
    var cmnd_img_before_src: String?
    var cmnd_img_after_src: String?
    var gpkd_img_after_src: String?
    var gpkd_img_before_src: String?
    var email: String?
    var gender: String?
    var birthday: Date?
    var material: [MaterialEntity]?
    var img: [ImgEntity]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.id <- map["id"]
        self.code_tax <- map["code_tax"]
        self.name <- map["name"]
        self.type_id <- map["type_id"]
        self.address <- map["address"]
        self.price <- (map["price"], StringToDoubleTransform())
        self.package_price <- (map["package_price"], StringToDoubleTransform())
        self.package_number <- map["package_number"]
        self.number_place <- map["number_place"]
        self.ordinal <- map["ordinal"]
        self.is_active <- map["is_active"]
        self.create_time <- (map["create_time"], TimeTramsform())
        self.time_start <- (map["time_start"], TimeTramsform())
        self.time_end <- (map["time_end"], TimeTramsform())
        self.lat <- (map["lat"], StringToDoubleTransform())
        self.long <- (map["long"], StringToDoubleTransform())
        self.rating <- map["rating"]
        self.account_id <- map["account_id"]
        self.parking_type <- map["parking_type"]
        self.fullname <- map["fullname"]
        self.identity_number <- map["identity_number"]
        self.issued_date <- (map["issued_date"], TimeTramsform())
        self.issued_by <- map["issued_by"]
        self.cmnd_img_before_src <- map["cmnd_img_before_src"]
        self.cmnd_img_after_src <- map["cmnd_img_after_src"]
        self.gpkd_img_after_src <- map["gpkd_img_after_src"]
        self.gpkd_img_before_src <- map["gpkd_img_before_src"]
        self.email <- map["email"]
        self.gender <- map["gender"]
        self.birthday <- (map["birthday"], TimeTramsform())
        self.material <- map["material"]
        self.img <- map["img"]
    }
}

class MaterialEntity: BaseEntity {
    var id: String?
    var name: String?
    var plain_name: String?
    var is_active: Bool?
    var icon: String?
    var unset_icon: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        id <- map["_id"]
        name <- map["name"]
        plain_name <- map["plain_name"]
        is_active <- map["is_active"]
        icon <- map["icon"]
        unset_icon <- map["unset_icon"]
    }
}

class ImgEntity: BaseEntity {
    var id: String?
    var parking_id: String?
    var img_src: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.id <- map["_id"]
        self.parking_id <- map["parking_id"]
        self.img_src <- map["img_src"]
    }
    
    var imageURL: String? {
        if let urlString = self.img_src {
            return BASE_URL_IMAGE + urlString
        }
        return ""
    }
}
