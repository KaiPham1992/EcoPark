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
    var number_place: Int?
    var ordinal: String?
    var is_active: String?
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
    var parkedNumber: Int?
    var config_price: Double? = 1000
    var total_rating: String?
    var wait_app: String?
    var phone: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.id <- map["_id"]
        self.code_tax <- map["code_tax"]
        self.name <- map["name"]
        self.type_id <- map["type_id"]
        self.address <- map["address"]
        self.price <- (map["price"], StringToDoubleTransform())
        self.package_price <- (map["package_price"], StringToDoubleTransform())
        self.package_number <- map["package_number"]
        self.number_place <- (map["number_place"], StringToIntTransform())
        self.ordinal <- map["ordinal"]
        self.is_active <- map["is_active"]
        self.create_time <- (map["create_time"], TimeTramsform())
        self.time_start <- (map["time_start"], AppTimestampTransform())
        self.time_end <- (map["time_end"], AppTimestampTransform())
        
        self.lat <- (map["lat"], StringToDoubleTransform())
        self.long <- (map["long"], StringToDoubleTransform())
        self.rating <- (map["rating"], StringToDoubleTransform())
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
        self.parkedNumber <- map["parked_number"]
        self.config_price <- (map["config_price"], StringToDoubleTransform())
        self.total_rating <- map["total_rating"]
        self.wait_app <- map["wait_app"]
        self.phone <- map["phone"]
    }
    
    var url_gpkd_Before:  URL? {
        if let urlString = self.gpkd_img_before_src, let url = URL(string: BASE_URL_IMAGE + urlString) {
            return url
            
        }
        return nil
    }
    
    var url_gpkd_after:  URL? {
        if let urlString = self.gpkd_img_after_src, let url = URL(string: BASE_URL_IMAGE + urlString) {
            return url
            
        }
        return nil
    }
}

class MaterialEntity: BaseEntity {
    var id: String?
    var name: String?
    var plain_name: String?
    var is_active: String?
    var icon: String?
    var unset_icon: String?
    var type: UtilityModelType? {
        get {
            switch plain_name {
            case "mai che":
                return .roof
            case "rua xe":
                return .carwash
            case "sua xe":
                return .repair
            case "cho thue xe":
                return .rent
            case "atm":
                return .atm
            case "khach san":
                return .hotel
            case "ca phe":
                return .coffee
            default:
                return .superMarket
            }
        }
    }
    
    var urlOn: URL? {
        return URL(string: "\(BASE_URL_IMAGE)\(icon&)")
    }
    
    var urlOff: URL? {
           return URL(string: "\(BASE_URL_IMAGE)\(unset_icon&)")
       }
    
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
