//
//  UpdateInfoParkingParam.swift
//  EcoPark
//
//  Created by Tu DV on 11/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper

class UpdateInfoParkingParam: BaseParam {
    
    var parking_id : String?
    var parking_address : String?
    var gpkd_img_before_src : String?
    var gpkd_img_after_src : String?
    var parking_name : String?
    var parking_type_id : String?
    var number_place : Int?
    var time_start : String?
    var time_end : String?
    var code_tax : String?
    var price : Double?
    var package_price : Double?
    var package_number : String?
    var material : [String] = []
    
    override func mapping(map: Map) {
        
        self.parking_id <- map["parking_id"]
        self.parking_address <- map["parking_address"]
        self.gpkd_img_before_src <- map["gpkd_img_before_src"]
        self.gpkd_img_after_src <- map["gpkd_img_after_src"]
        self.parking_name <- map["parking_name"]
        self.parking_type_id <- map["parking_type_id"]
        self.number_place <- map["number_place"]
        self.time_start <- map["time_start"]
        self.time_end <- map["time_end"]
        self.code_tax <- map["code_tax"]
        self.price <- map["price"]
        self.package_price <- map["package_price"]
        self.package_number <- map["package_number"]
        self.material <- map["material"]
        
    }
    
    init(
        parking_id : String?,
        parking_address : String?,
        gpkd_img_before_src : String?,
        gpkd_img_after_src : String?,
        parking_name : String?,
        parking_type_id : String?,
        number_place : Int?,
        time_start : String?,
        time_end : String?,
        code_tax : String?,
        price : Double?,
        package_price : Double?,
        package_number : String?,
        material : [String] = []
    ) {
        super.init()
        self.parking_id = parking_id
        self.parking_address = parking_address
        self.gpkd_img_before_src = gpkd_img_before_src
        self.gpkd_img_after_src = gpkd_img_after_src
        self.parking_name = parking_name
        self.parking_type_id = parking_type_id
        self.number_place = number_place
        self.time_start = time_start
        self.time_end = time_end
        self.code_tax = code_tax
        self.price = price
        self.package_price = package_price
        self.package_number = package_number
        self.material = material
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}
