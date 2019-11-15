//
//  BossRegisterParam.swift
//  EcoPark
//
//  Created by Tu DV on 11/13/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper

class BossRegisterParam: BaseParam {
    
    var email: String?
    var fullname: String?
    var gender: String?
    var birthday: String?
    var identity_number: String?
    var issued_by: String?
    var issued_date: String?
    var cmnd_img_before_src: UIImage?
    var cmnd_img_after_src: UIImage?
    var gpkd_img_before_src: UIImage?
    var gpkd_img_after_src: UIImage?
    var parking_name: String?
    var parking_type_id: String?
    var number_place: String?
    var parking_address: String?
    var time_start: String?
    var time_end: String?
    var code_tax: String?
    var price: String?
    var package_price: String?
    var material: [String] = []
    var parking_img_src: [UIImage] = []
    
    override func mapping(map: Map) {
        self.email <- map["email"]
        self.fullname <- map["fullname"]
        self.gender <- map["gender"]
        self.birthday <- map["birthday"]
        self.identity_number <- map["identity_number"]
        self.issued_by <- map["issued_by"]
        self.issued_date <- map["issued_date"]
        self.cmnd_img_before_src <- map["cmnd_img_before_src"]
        self.cmnd_img_after_src <- map["cmnd_img_after_src"]
        self.gpkd_img_before_src <- map["gpkd_img_before_src"]
        self.gpkd_img_after_src <- map["gpkd_img_after_src"]
        self.parking_name <- map["parking_name"]
        self.parking_type_id <- map["parking_type_id"]
        self.number_place <- map["number_place"]
        self.parking_address <- map["parking_address"]
        self.time_start <- map["time_start"]
        self.time_end <- map["time_end"]
        self.code_tax <- map["code_tax"]
        self.price <- map["price"]
        self.package_price <- map["package_price"]
        self.material <- map["mertirial_id"]
        self.parking_img_src <- map["parking_img_src"]
    }
    
     init(
        email: String?,
        fullname: String?,
        gender: String?,
        birthday: String?,
        identity_number: String?,
        issued_by: String?,
        issued_date: String?,
        cmnd_img_before_src: UIImage?,
        cmnd_img_after_src: UIImage?,
        gpkd_img_before_src: UIImage?,
        gpkd_img_after_src: UIImage?,
        parking_name: String?,
        parking_type_id: String?,
        number_place: String?,
        parking_address: String?,
        time_start: String?,
        time_end: String?,
        code_tax: String?,
        price: String?,
        package_price: String?,
        material: [String] = [],
        parking_img_src: [UIImage] = []) {
        
        super.init()
        self.email = email
        self.fullname = fullname
        self.gender = gender
        self.birthday = birthday
        self.identity_number = identity_number
        self.issued_by = issued_by
        self.issued_date = issued_date
        self.cmnd_img_before_src = cmnd_img_before_src
        self.cmnd_img_after_src = cmnd_img_after_src
        self.gpkd_img_before_src = gpkd_img_before_src
        self.gpkd_img_after_src = gpkd_img_after_src
        self.parking_name = parking_name
        self.parking_type_id = parking_type_id
        self.number_place = number_place
        self.parking_address = parking_address
        self.time_start = time_start
        self.time_end = time_end
        self.code_tax = code_tax
        self.price = price
        self.package_price = package_price
        self.material = material
        self.parking_img_src = parking_img_src
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
    
}
